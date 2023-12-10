# Ubuntu

Download the desktop version and create an USB stick with dd. When installing,
choose:

 * Minimal Installation
 * Download updates while installing Ubuntu
 * Install thirdy party software

After booting the new system for the first time:

```bash
sudo apt update
sudo apt upgrade
sudo apt autoremove
```

## VirtualBox Guest Additions

If installed inside VirtualBox, install Guest Additions now. Dependencies such
as `dkms` and `build-essential` (check Google since these may change between
Ubuntu versions) should be installed from Ubuntu repositories, but the Guest
Additions itself should be installed from "CD Image" which is mountable from
the VirtualBox user interface. Reboot after installation.

## Nerd font

Install Jetbrains Mono Nerd font with the following commands:

```bash
mkdir -p ~/.fonts/JetBrainsMono
cd ~/.fonts/JetBrainsMono
curl -L -O https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip JetBrainsMono.zip
rm JetBrainsMono.zip
fc-cache -fv
```

## Gnome

Install customization tools with the following command:

```bash
sudo apt install git gnome-shell-extensions gnome-tweaks
```

Then go through Gnome Tweaks and Extensions to set the user interface as you
like. This includes things such as:

* Hiding or otherwise configuring the Dock and other Ubuntu related
  extensions.
* Setting up GTK and icon themes.
* Setting up a wallpaper.

It's also a good time to configure Gnome Terminal (theme, font, etc).

## Zsh

Install Zsh, Pure-prompt and related dots with the following command:

```bash
sudo apt install zsh
chsh -s $(which zsh)
mkdir -p "$HOME/.zsh"
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
curl https://raw.githubusercontent.com/MattiNieminen/realms/main/dots/zsh/.zshrc -o ~/.zshrc
```
