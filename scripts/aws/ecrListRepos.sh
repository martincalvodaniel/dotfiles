#!/bin/bash

# Strict mode: safer scripting
set -euo pipefail

# This script lists all ECR repositories and their details including image count, total size, creation date, last pushed date, last pulled date, and terraform tag.
# It generates a CSV file with the collected data.
#
# Usage:
#   ./ecrListRepos.sh [--filter FILTER]
# Options:
#   -f, --filter    Filter repositories containing the specified string
#   -h, --help      Display this help message
#
# Example:
#   ./ecrListRepos.sh --filter my-repo
#
# Requirements:
#   - AWS CLI configured (aws)
#   - jq
#   - bc

print_usage() {
    echo "Usage: $0 [--filter FILTER]"
    echo "  -f, --filter    Filter repositories containing the specified string"
    echo "  -h, --help      Display this help message"
    echo "Example:"
    echo "  $0 --filter my-repo"
}

dep_check() {
    for dep in aws jq bc; do
        if ! command -v "$dep" >/dev/null 2>&1; then
            echo "Error: Required dependency '$dep' is not installed." >&2
            exit 2
        fi
    done
}

dep_check

initialize_csv() {
    local timestamp script_name output_file sanitized_filter
    timestamp=$(date '+%Y%m%d-%H%M')
    script_name="ecrListRepos"
    output_file="${script_name}-${timestamp}"
    if [[ -n "${filter:-}" ]]; then
        # Replace '/' with '-' in the filter to make it a valid filename
        sanitized_filter=$(echo "$filter" | tr '/' '-')
        output_file+="-$sanitized_filter"
    fi
    output_file+=".csv"

    # Initialize CSV with headers
    echo "repository,image_count,total_size_bytes,total_size_gb,created_at,last_pushed_date,last_pulled_date,terraform_tag" > "$output_file"
    echo "$output_file"
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

# Argument parsing
filter=""
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -f|--filter)
            if [[ -n "${2:-}" ]]; then
                filter="$2"; shift
            else
                echo "Error: --filter requires a value." >&2; print_usage; exit 1
            fi
            ;;
        -h|--help)
            print_usage; exit 0 ;;
        *)
            echo "Unknown parameter passed: $1" >&2; print_usage; exit 1 ;;
    esac
    shift
done

output_file=$(initialize_csv)

repositories=$(aws ecr describe-repositories | jq -c '.repositories[] | {repositoryName, repositoryArn, createdAt}')

if [[ -n "$filter" ]]; then
    repositories=$(echo "$repositories" | jq -c "select(.repositoryName | contains(\"$filter\"))")
fi

# Convert to array for safe iteration
mapfile -t repo_array < <(echo "$repositories")

for repository in "${repo_array[@]}"; do
    repository_name=$(echo "$repository" | jq -r '.repositoryName')
    repository_arn=$(echo "$repository" | jq -r '.repositoryArn')
    created_at=$(echo "$repository" | jq -r '.createdAt')
    created_at=$(format_date "$created_at")
    echo "--------------------------------------------------------------------------------"
    echo "Repository: $repository_name"
    echo "Repository ARN: $repository_arn"

    if ! image_details=$(aws ecr describe-images --repository-name "$repository_name" 2>/dev/null); then
        echo "Warning: Could not fetch images for $repository_name" >&2
        image_count=0
        total_size_bytes=0
        total_size_gb=0
        last_pushed_date=""
        last_pulled_date=""
    else
        image_count=$(echo "$image_details" | jq '.imageDetails | length')
        echo "Total number of images: $image_count"
        if [[ "$image_count" -eq 0 ]]; then
            total_size_bytes=0
            total_size_gb=0
        else
            total_size_bytes=$(echo "$image_details" | jq '[.imageDetails[].imageSizeInBytes] | add // 0')
            total_size_gb=$(echo "scale=2; ${total_size_bytes} / (1024 * 1024 * 1024)" | bc -l)
            if [[ $total_size_gb == .* ]]; then
                total_size_gb="0$total_size_gb"
            fi
        fi
        last_pushed_date=$(echo "$image_details" | jq -r '.imageDetails[].imagePushedAt | select(. != null)' | sort -r | head -n1)
        last_pushed_date=$(format_date "$last_pushed_date")
        last_pulled_date=$(echo "$image_details" | jq -r '.imageDetails[].lastRecordedPullTime | select(. != null)' | sort -r | head -n1)
        last_pulled_date=$(format_date "$last_pulled_date")
    fi
    echo "Total size in bytes: ${total_size_bytes}"
    echo "Total size of all images in $repository_name: ${total_size_gb} GB"
    echo "Created At: $created_at"
    echo "Last pushed date: ${last_pushed_date}"
    echo "Last pulled date: ${last_pulled_date}"

    # Get tags for the repository
    terraform_tag="false"
    if tags=$(aws ecr list-tags-for-resource --resource-arn "$repository_arn" 2>/dev/null); then
        terraform_tag=$(echo "$tags" | jq -r '.tags[] | select(.Key == "terraform") | .Value // "false"' || echo "false")
        [[ -z "$terraform_tag" ]] && terraform_tag="false"
    fi
    echo "Terraform tag: $terraform_tag"

    echo "$repository_name,$image_count,$total_size_bytes,$total_size_gb,$created_at,$last_pushed_date,$last_pulled_date,$terraform_tag" >> "$output_file"
done

echo "--------------------------------------------------------------------------------"
echo "Output file: $output_file"

# Optionally copy to Windows Desktop if running in WSL and env var is set
if grep -qi microsoft /proc/version 2>/dev/null && [[ -n "${WINDOWS_USER:-}" ]]; then
    win_dest="/mnt/c/Users/$WINDOWS_USER/Desktop"
    if [[ -d "$win_dest" ]]; then
        cp "$output_file" "$win_dest" && echo "Copied to $win_dest" || echo "Failed to copy to $win_dest" >&2
    else
        echo "Windows Desktop path not found: $win_dest" >&2
    fi
fi
