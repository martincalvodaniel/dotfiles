function cdd() {
  cd "$(find . -maxdepth 1 -type d | fzf)" || echo "Invalid directory"
}

function recent_dirs() {
  # This script depends on pushd. It works better with autopush enabled in ZSH
  escaped_home=$(echo $HOME | sed 's/\//\\\//g')
  selected=$(dirs -p | sort -u | fzf)

  cd "$(echo "$selected" | sed "s/\~/$escaped_home/")" || echo "Invalid directory"
}

function docker_remove() {
    docker ps -a | fzf | awk '{print $12}' | xargs docker rm -f | awk '{print "Removed container with name "$1}'
}
function docker_remove_image() {
    docker images | fzf | awk '{print $1}' | xargs docker rmi
}

function rmGradle() {
  local gradle_version="${1}"

  if [[ "$gradle_version" == "-h" || "$gradle_version" == "--help" ]]; then
    echo "Usage: rmGradle <gradle_version>"
    echo "  gradle_version - Version of Gradle to remove (required)"
    return 0
  fi

  if [[ -z "$gradle_version" ]]; then
    echo "Usage: rmGradle <gradle_version>" >&2
    return 1
  fi

  read -q "?Remove Gradle ${gradle_version}.* caches? (y/n) " || return 1
  echo

  echo "Removing ~/.gradle/caches/${gradle_version}*"
  rm -rf ~/.gradle/caches/${gradle_version}*
  echo "Removing ~/.gradle/daemon/${gradle_version}*"
  rm -rf ~/.gradle/daemon/${gradle_version}*
  echo "Removing ~/.gradle/wrapper/dists/gradle-${gradle_version}*"
  rm -rf ~/.gradle/wrapper/dists/gradle-${gradle_version}*
  echo "Gradle ${gradle_version} caches cleaned successfully!"
}

function topDiskUsage() {
  local path="${1:-.}"
  local max_depth="${2:-3}"
  local limit="${3:-50}"

  if [[ "$path" == "-h" || "$path" == "--help" ]]; then
    echo "Usage: topDiskUsage [path] [max_depth] [limit]"
    echo "  path       - Directory to analyze (default: .)"
    echo "  max_depth  - Maximum directory depth (default: 3)"
    echo "  limit      - Number of top results to show (default: 50)"
    return 0
  fi

  /usr/bin/du -h --max-depth="${max_depth}" "${path}" | /usr/bin/sort -rh | /usr/bin/head -n "${limit}"
}

function killCustom() {
  if [[ "$1" == "-h" || "$1" == "--help" || -z "$1" ]]; then
    echo "Usage: killCustom <pid1> <pid2> ..."
    echo "  Sends CONT, TERM, HUP, and KILL signals to the specified PIDs with a 1-second pause between each."
    return 0
  fi
  kill -CONT "$@"
  kill -TERM "$@"
  kill -HUP "$@"
  echo "Waiting 1 second before sending KILL signal to $@..."
  sleep 1
  kill -KILL "$@"
}

function go-to-today() {
  # Get today's date in YY/MM/DD format
  local today=$(date +%y/%m/%d)
  
  # Set the journal directory
  local journal_dir="$HOME/journal"
  
  # Create the directory if it doesn't exist
  mkdir -p "$journal_dir/$today"
  
  # Navigate to today's folder
  cd "$journal_dir/$today"
}