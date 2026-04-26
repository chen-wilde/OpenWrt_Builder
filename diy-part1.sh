#!/bin/bash
#
# https://github.com/chen-wilde/Actions-OpenWrt
#
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Add a feed source
 sed -i '1i src-git passwall_luci https://github.com/Openwrt-Passwall/openwrt-passwall.git' feeds.conf.default
 sed -i '1i src-git passwall_packages https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git' feeds.conf.default