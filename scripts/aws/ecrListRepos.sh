#!/bin/bash

initialize_csv() {
    local current_timestamp=$(date +"%y%m%d%H%M")
    local output_file="ecr_repo_sizes-${current_timestamp}"
    if [[ -n "$filter" ]]; then
        # Replace '/' with '-' in the filter to make it a valid filename
        sanitized_filter=$(echo "$filter" | tr '/' '-')
        output_file+="-$sanitized_filter"
    fi
    output_file+=".csv"
    echo "repository,image_count,total_size_bytes,total_size_gb,created_at,last_pushed_date,last_pulled_date,terraform_tag" > "$output_file"
    echo "$output_file"
}

print_usage() {
    echo "Usage: $0 [--filter FILTER]"
    echo "  -f, --filter    Filter repositories containing the specified string"
    echo "  -h, --help      Display this help message"
}

format_date() {
    local date_to_format="$1"
    if [[ -n "$date_to_format" ]]; then
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS date command
            date_to_format=$(date -jf "%Y-%m-%dT%H:%M:%S" "${date_to_format%.*}" "+%Y-%m-%d %H:%M:%S")
        else
            # GNU date command (Linux)
            date_to_format=$(date -d "$date_to_format" '+%Y-%m-%d %H:%M:%S')
        fi
    fi
    echo "$date_to_format"
}

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -f | --filter) filter="$2"; shift ;;
        -h | --help) print_usage; exit 0 ;;
        *) echo "Unknown parameter passed: $1"; print_usage; exit 1 ;;
    esac
    shift
done

output_file=$(initialize_csv)

repositories=$(aws ecr describe-repositories | jq -c '.repositories[] | {repositoryName, repositoryArn, createdAt}')

if [[ -n "$filter" ]]; then
    repositories=$(echo "$repositories" | jq -c "select(.repositoryName | contains(\"$filter\"))")
fi

for repository in $(echo "$repositories" | jq -c '.')
do
    repository_name=$(echo "$repository" | jq -r '.repositoryName')
    repository_arn=$(echo "$repository" | jq -r '.repositoryArn')
    created_at=$(echo "$repository" | jq -r '.createdAt')
    created_at=$(format_date "$created_at")
    echo "--------------------------------------------------------------------------------"
    echo "Repository: $repository_name"
    echo "Repository ARN: $repository_arn"

    image_details=$(aws ecr describe-images --repository-name $repository_name)

    image_count=$(echo "${image_details}" | jq '.imageDetails | length')
    echo "Total number of images: $image_count"

    if [ "$image_count" -eq 0 ]; then
        total_size_bytes="0"
        total_size_gb="0"
    else
        total_size_bytes=$(echo "${image_details}" | jq '[.imageDetails[].imageSizeInBytes] | add')
        total_size_gb=$(echo "scale=2; ${total_size_bytes} / (1024 * 1024 * 1024)" | bc -l)
        # Add 0 before decimal point if needed
        if [[ $total_size_gb == .* ]]; then
            total_size_gb="0$total_size_gb"
        fi
    fi
    echo "Total size in bytes: ${total_size_bytes}"
    echo "Total size of all images in $repository_name: ${total_size_gb} GB"
    echo "Created At: $created_at"

    # Get the latest push date and convert from ISO 8601 to readable format
    last_pushed_date=$(echo "${image_details}" | jq -r '.imageDetails[].imagePushedAt | select(. != null)' | sort -r | head -n1)
    last_pushed_date=$(format_date "$last_pushed_date")
    echo "Last pushed date: ${last_pushed_date}"

    # Get the latest pull date and convert from ISO 8601 to readable format
    last_pulled_date=$(echo "${image_details}" | jq -r '.imageDetails[].lastRecordedPullTime | select(. != null)' | sort -r | head -n1)
    last_pulled_date=$(format_date "$last_pulled_date")
    echo "Last pulled date: ${last_pulled_date}"

    # Get tags for the repository
    tags=$(aws ecr list-tags-for-resource --resource-arn $repository_arn)
    terraform_tag=$(echo "$tags" | jq -r '.tags[] | select(.Key == "terraform") | .Value // "false"')
    if [ -z "$terraform_tag" ]; then
        terraform_tag="false"
    fi
    echo "Terraform tag: $terraform_tag"

    echo "$repository_name,$image_count,$total_size_bytes,$total_size_gb,$created_at,$last_pushed_date,$last_pulled_date,$terraform_tag" >> "$output_file"
done

echo "--------------------------------------------------------------------------------"
echo "Output file: $output_file"

cp $output_file /mnt/c/Users/$ORG_GRADLE_PROJECT_nexusUser/Desktop
