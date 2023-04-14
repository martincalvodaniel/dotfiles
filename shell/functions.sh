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
    docker images -a | fzf | awk '{print $1}' | xargs docker rmi
}