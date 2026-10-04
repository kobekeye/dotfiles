#!/usr/bin/env bash


# config
set -e

dotfiles_dir="$(cd "$(dirname "$0")" && pwd)"
config_dir="$dotfiles_dir/config"
system_config_dir="${XDG_CONFIG_HOME:-$HOME/.config}"

config_items=(
    nvim
    kitty
    hypr
    waybar
    wofi
    code-flags.conf
    sway
    zathura
    sioyek
    rofi
    quickshell
    helix
    dunst
    networkmanager-dmenu
)

mkdir -p "$config_dir"
mkdir -p "$system_config_dir"

for name in "${config_items[@]}"; do
    repo_path="$config_dir/$name"
    system_path="$system_config_dir/$name"

    # mv
    if [[ ! -e "$repo_path" && ! -L "$repo_path" ]]; then
        if [[ -e "$system_path" && ! -L "$system_path" ]]; then
            mv "$system_path" "$repo_path"
            echo "move：$system_path -> $repo_path"
        else
            echo "skipped: cannot find $name"
            continue
        fi
    fi

    # already linked
    if [[ -L "$system_path" ]] &&
       [[ "$(readlink -f "$system_path")" == "$(readlink -f "$repo_path")" ]]; then
        echo "skipped: $system_path has been correctly linked"
        continue
    fi

    # ~/dotfiles/ and ~/.config/ both exist
    if [[ -e "$system_path" || -L "$system_path" ]]; then
        echo "conflict: $system_path already exists"
        continue
    fi

    ln -s "$repo_path" "$system_path"
    echo "link: $system_path -> $repo_path"
done


# ~
home_dir="$dotfiles_dir/home"

home_items=(
    .zshrc
    .p10k.zsh
    .bashrc
)

mkdir -p "$home_dir"

for name in "${home_items[@]}"; do
    repo_path="$home_dir/$name"
    system_path="$HOME/$name"

    if [[ ! -e "$repo_path" && ! -L "$repo_path" ]]; then
        if [[ -e "$system_path" && ! -L "$system_path" ]]; then
            mv "$system_path" "$repo_path"
            echo "move: $system_path -> $repo_path"
        else
            echo "skipped: cannot find $name"
            continue
        fi
    fi

    if [[ -L "$system_path" ]] &&
       [[ "$(readlink -f "$system_path")" == "$(readlink -f "$repo_path")" ]]; then
        echo "skipped: $system_path has been correctly linked."
        continue
    fi

    if [[ -e "$system_path" || -L "$system_path" ]]; then
        echo "conflict: $system_path already exists"
        continue
    fi

    ln -s "$repo_path" "$system_path"
    echo "link: $system_path -> $repo_path"
done

# local/share
local_share_dir="$dotfiles_dir/local/share"
system_local_share_dir="${XDG_DATA_HOME:-$HOME/.local/share}"

local_share_items=(
    typst
)

mkdir -p "$local_share_dir"
mkdir -p "$system_local_share_dir"

for name in "${local_share_items[@]}"; do
    repo_path="$local_share_dir/$name"
    system_path="$system_local_share_dir/$name"

    if [[ ! -e "$repo_path" && ! -L "$repo_path" ]]; then
        if [[ -e "$system_path" && ! -L "$system_path" ]]; then
            mv "$system_path" "$repo_path"
            echo "move: $system_path -> $repo_path"
        else
            echo "skipped: cannot find $name"
            continue
        fi
    fi

    if [[ -L "$system_path" ]] &&
       [[ "$(readlink -f "$system_path")" == "$(readlink -f "$repo_path")" ]]; then
        echo "skipped: $system_path has been correctly linked"
        continue
    fi

    if [[ -e "$system_path" || -L "$system_path" ]]; then
        echo "conflict: $system_path already exists"
        continue
    fi

    ln -s "$repo_path" "$system_path"
    echo "link: $system_path -> $repo_path"
done
