if [ -t 0 ]; then
  if [ -n "$(ls /run/current-system/specialisation)" ]; then
    echo Swap
  fi
  echo Current
  echo Booted
else
  read -r line
  if [ "$line" = "Swap" ]; then
    cmd="/run/current-system/specialisation/$(ls /run/current-system/specialisation -X | rofi -dmenu)/bin/switch-to-configuration test"
  elif [ "$line" = "Current" ]; then
    cmd="revert-specialisation"
  elif [ "$line" = "Booted" ]; then
    cmd="/run/booted-system/specialisation/bin/switch-to-configuration test"
  fi
  nix run nixpkgs#kitty -- -e sh -c "sudo $cmd"
fi


