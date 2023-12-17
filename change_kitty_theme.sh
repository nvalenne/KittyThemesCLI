#! /bin/bash

# Set the variables
green='\033[0;32m'
red='\033[0;31m'
yellow='\033[0;33m'
underline='\e[4m'
clear='\e[0m'
space=".........."
kitty_conf_path=~/.config/kitty/kitty.conf
kitty_themes_path=$(realpath ./kitty-themes/themes/)/

# function for print messages with colors
print_message() { printf "$2$1${clear}\n"; }

list_themes() {
  print_message "List of themes:" $yellow
  ls $kitty_themes_path | cut -d . -f 1
}

# Check if include line is in kitty.conf
find_line_in_kitty_config() {
  if grep "include $kitty_themes_path" $kitty_conf_path >/dev/null; then
    print_message "kitty.conf$space Line found" $yellow
    return 0
  else
    print_message "kitty.conf$space Line not found" $red
    return 1
  fi
}

reloadKitty() {
  # call -SIGUSR1 signal to reload kitty config
  print_message "Reloading kitty..." $yellow
  kill -SIGUSR1 $(pgrep -f kitty)
}

help() {
  print_message "Usage: ./change_kitty_theme.sh [theme_name]" $green
  print_message "${underline}Options:${clear}" $yellow
  print_message "  ${yellow}-h, --help$space${clear} ${underline}Show this help message and exit"
  print_message "  ${yellow}-c, --current$space${clear} ${underline}Show the current theme" $yellow
  print_message "  ${yellow}-l, --list$space${clear} ${underline}List all the themes" $yellow
  print_message "  ${yellow}-reload$space${clear} ${underline}Reload kitty" $yellow
  print_message "  ${yellow}-remove$space${clear} ${underline}Remove the theme" $yellow
  print_message "Example: change_kitty_theme.sh Brogrammer" $green
  exit 0
}

current_theme() {
  # Get the current theme in kitty.conf
  current_theme=$(grep "include $kitty_themes_path" $kitty_conf_path | awk '{print $NF}')
  if [[ -z $current_theme ]]; then
    print_message "You have not chosen a theme yet" $red
    exit 1
  else
    current_theme=$(basename $current_theme .conf)
    print_message "Current theme: ${underline}$current_theme${clear}" $green
  fi
}

change_theme() {
  # Check if the theme name is empty
  if [[ -z $1 ]]; then
    help
  fi

  theme_file="$1.conf"

  # Check if the theme exist
  if [[ $(find $kitty_themes_path -name "$theme_file") ]]; then
    print_message "kitty-themes/$space Theme found" $yellow
    print_message "Changing the theme..." $yellow
    if find_line_in_kitty_config; then
      # get the line number where the include line is actually
      new_line="include $kitty_themes_path$theme_file"
      line_number=$(grep -n "include $kitty_themes_path" $kitty_conf_path | cut -d : -f 1)
      # Delete the line and add the new one
      sed -i "${line_number}d" $kitty_conf_path
      sed -i "${line_number}i$new_line" $kitty_conf_path
    else
      print_message "kitty.conf$space Create the line..." $yellow
      # Add the include line at the top of the file
      sed -i "1iinclude $kitty_themes_path$theme_file" $kitty_conf_path
    fi
    print_message "kitty.conf$space File changed" $yellow
    print_message "\nTheme changed successfully => ${underline}$1${clear}" $green
  else
    # If the theme doesn't exist
    print_message "kitty-themes/$space Theme not found" $red
    exit 1
  fi

  # Send a signal to kitty to reload the config
  reloadKitty
}

remove_theme() {
  theme=$(grep "include $kitty_themes_path" $kitty_conf_path | cut -d / -f 4 | cut -d . -f 1)
  line_number=$(grep -n "include $kitty_themes_path" $kitty_conf_path | cut -d : -f 1)
  if [[ -z $line_number ]]; then
    print_message "kitty.conf$space Theme not found or already removed" $red
    exit 1
  fi
  # Delete the line
  sed -i "${line_number}d" $kitty_conf_path
  print_message "kitty.conf$space $theme removed" $yellow
}


case $1 in
-h | --help)
  help
  ;;
-c | --current)
  current_theme
  exit 0
  ;;
-l | --list)
  list_themes
  exit 0
  ;;
-reload)
  reloadKitty
  exit 0
  ;;
-remove)
  remove_theme
  reloadKitty
  exit 0
  ;;
*)
  change_theme $1
  exit 0
  ;;

esac
