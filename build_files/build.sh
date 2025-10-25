#!/bin/bash

set -ouex pipefail

### add mount target /nix

# lix ostree installer use /home/nix, and mount on /nix
mkdir -p /nix

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# fcitx5 はデフォルトで入っている。
dnf5 remove fcitx5 fcitx5-gtk fcitx5-mozc

# Use a COPR
#
dnf5 -y copr enable yalter/niri
dnf5 -y install niri

dnf5 -y copr enable scottames/ghostty
dnf5 -y install ghostty

dnf5 -y copr enable blakegardner/xremap
dnf5 -y install xremap-niri

# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable yalter/niri
dnf5 -y copr disable scottames/ghostty
dnf5 -y copr disable blakegardner/xremap

#### Example for enabling a System Unit File

systemctl enable podman.socket
