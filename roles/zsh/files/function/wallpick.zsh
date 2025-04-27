#!/usr/bin/env zsh

wallpick() {
  local chooser="/tmp/yazi-wallpaper"
  yazi --chooser-file="$chooser" ~/Pictures/Wallpapers

  if [[ -f "$chooser" ]]; then
    local image
    image=$(<"$chooser")
    osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$image\""
    echo "Wallpaper set to: $image"
    rm "$chooser"
  else
    echo "No image selected."
  fi
}
