# KittyThemesCLI
![Bash](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Bash](https://img.shields.io/badge/GNU%20Bash-4EAA25?style=for-the-badge&logo=GNU%20Bash&logoColor=white)

CLI to manage your themes on Kitty Terminal
## About
You'll find what you need to manage your themes for [Kitty terminal](https://github.com/kovidgoyal/kitty). you can use the existing themes or import your owns themes in the folder [kitty-themes/themes](./kitty-themes/themes/).
## License
All content of this repository is licensed with [MIT License](./LICENSE)

Existing themes in ```/kitty-themes/themes``` were taken of [this repository](https://github.com/dexpota/kitty-themes) made by [Nexpota](https://github.com/dexpota), licensed with [MIT License](https://github.com/dexpota/kitty-themes/blob/master/LICENSE.md). 

Previews of the themes are available on the repository of [Kitty-Themes](https://github.com/dexpota/kitty-themes/).

## Installation

1. Make sure kitty is installed on your computer
2. Clone the repository in the directory you want (preferably at the same place as ```kitty.conf```)
    - HTTPS
    ```bash
        git clone https://github.com/nvalenne/KittyThemesCLI.git
    ```
    - SSH
    ```bash
        git clone git@github.com:nvalenne/KittyThemesCLI.git
    ```
3. Now, you can use the CLI as you want !
### Warning
> If your ```kitty.conf``` is installed on an another directory than ```~/.config/kitty```, you can edit this line in the [script](change_kitty_theme.sh) :
> ```bash
> kitty_conf_path=~/.config/kitty/kitty.conf
> ```
## Usage

- -h, --help = Show this help message and exit
- -c, --current = Show the current theme
- -l, --list = List all the themes
- -reload = Reload kitty
- -remove = Remove the theme
``` bash
./change_kitty_theme.sh [theme_name]
```

