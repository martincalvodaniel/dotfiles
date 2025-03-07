#!/bin/bash

initialize_csv() {
    local current_timestamp=$(date +"%y%m%d%H%M")
    local output_file="ecr_repo_sizes-${current_timestamp}.csv"
    echo "repository,image_count,total_size_bytes,total_size_gb,last_pushed_date,last_pulled_date" > "$output_file"
    echo "$output_file"
}

print_usage() {
    echo "Usage: $0 [--filter FILTER]"
    echo "  -f, --filter    Filter repositories containing the specified string"
    echo "  -h, --help      Display this help message"
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

repositories=$(aws ecr describe-repositories | jq -r '.repositories[].repositoryName' | sort)

if [[ -n "$filter" ]]; then
    repositories=$(echo "$repositories" | grep "$filter")
fi

for repository in $(echo $repositories)
do
    echo "--------------------------------------------------------------------------------"
    echo "Repository: $repository"
    image_details=$(aws ecr describe-images --repository-name $repository)

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
    echo "Total size of all images in $repository: ${total_size_gb} GB"

    # Get the latest push date and convert from ISO 8601 to readable format
    last_pushed_date=$(echo "${image_details}" | jq -r '.imageDetails[].imagePushedAt | select(. != null)' | sort -r | head -n1)
    if [ -n "$last_pushed_date" ]; then
        # Use date with proper parsing of ISO 8601 format
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS date command
            last_pushed_date=$(date -jf "%Y-%m-%dT%H:%M:%S" "${last_pushed_date%.*}" "+%Y-%m-%d %H:%M:%S")
        else
            # GNU date command (Linux)
            last_pushed_date=$(date -d "${last_pushed_date}" '+%Y-%m-%d %H:%M:%S')
        fi
    fi
    echo "Last pushed date: ${last_pushed_date}"

    # Get the latest pull date and convert from ISO 8601 to readable format
    last_pulled_date=$(echo "${image_details}" | jq -r '.imageDetails[].lastRecordedPullTime | select(. != null)' | sort -r | head -n1)
    if [ -n "$last_pulled_date" ]; then
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS date command
            last_pulled_date=$(date -jf "%Y-%m-%dT%H:%M:%S" "${last_pulled_date%.*}" "+%Y-%m-%d %H:%M:%S")
        else
            # GNU date command (Linux)
            last_pulled_date=$(date -d "${last_pulled_date}" '+%Y-%m-%d %H:%M:%S')
        fi
    fi
    echo "Last pulled date: ${last_pulled_date}"

    echo "$repository,$image_count,$total_size_bytes,$total_size_gb,$last_pushed_date,$last_pulled_date" >> "$output_file"
done

echo "Output file: $output_file"

cp $output_file /mnt/c/Users/$ORG_GRADLE_PROJECT_nexusUser/Desktop
