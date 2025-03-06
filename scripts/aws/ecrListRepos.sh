#!/bin/bash

initialize_csv() {
    local current_timestamp=$(date +"%y%m%d%H%M")
    local output_file="ecr_repo_sizes-${current_timestamp}.csv"
    echo "repository,image_count,total_size_bytes,total_size_gb" > "$output_file"
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
echo "Output file: $output_file"

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

    total_size_bytes=$(echo "${image_details}" | jq '[.imageDetails[].imageSizeInBytes] | add')
    echo "Total size in bytes: ${total_size_bytes}"

    total_size_gb=$(echo "scale=2; ${total_size_bytes} / (1024 * 1024 * 1024)" | bc -l)
    # Añadir 0 antes del punto decimal si es necesario
    if [[ $total_size_gb == .* ]]; then
        total_size_gb="0$total_size_gb"
    fi
    echo "Total size of all images in $repository: ${total_size_gb} GB"

    echo "$repository,$image_count,$total_size_bytes,$total_size_gb" >> "$output_file"
done

echo "Output file: $output_file"
