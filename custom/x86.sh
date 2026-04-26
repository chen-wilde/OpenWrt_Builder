#!/bin/bash
#
# https://github.com/chen-wilde/OpenWrt_Builder
#
# File name: x86.sh
# Description: OpenWrt script for create remote config (Before diy script part 2)
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

mkdir -p files/etc/cloudflared
echo "$TUNNEL_CERT" > files/etc/cloudflared/cert.pem
sed -i "s/::0/$PASSWD/" package/base-files/files/etc/shadow

cd feeds/packages/net
echo "$FRPC_OP" > frp/files/frpc.config
sed -i "s/enabled '0'/enabled '1'/" banip/files/banip.conf
sed -i "s/enabled '0'/enabled '1'/;s/token ''/token '$TUNX86_TOKEN'/" cloudflared/files/cloudflared.config