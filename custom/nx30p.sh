#!/bin/bash
#
# https://github.com/chen-wilde/OpenWrt_Builder
#
# File name: nx30p.sh
# Description: OpenWrt script for create remote config (Before diy script part 2)
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

sed -i 's/4000000>/7280000>/' target/linux/mediatek/dts/mt7981b-h3c-magic-nx30-pro.dts package/boot/uboot-mediatek/patches/435-add-h3c_magic-nx30-pro.patch

mkdir -p files/etc/{config,cloudflared}
echo "$FW4_HTTPS" > files/etc/config/firewall
echo "$WIFI_NX30P" > files/etc/config/wireless
echo "$TUNNEL_CERT" > files/etc/cloudflared/cert.pem

cd package/base-files/files
sed -i "s/::0/$PASSWD/" etc/shadow
sed -i 's/-dhcp/-pppoe/' lib/functions/uci-defaults.sh
sed -i "s/'username'/'$PPPOE_USER'/;s/'password'/'006688'/" bin/config_generate

cd ../../network/services/uhttpd/files
sed -i '/-s "$UHTTPD_CERT"/,/}/d' uhttpd.init
sed -i "s/uhttpd.crt/$DOMAIN_NX30P.fullchain.crt/;s/uhttpd.key/$DOMAIN_NX30P.key/" uhttpd.config

cd ../../../../../feeds/packages/net
echo "$ACME_NX30P" > acme-common/files/acme.config
echo "$DDNS_NX30P" > ddns-scripts/files/etc/config/ddns

sed -i "s/enabled '0'/enabled '1'/" banip/files/banip.conf
sed -i '/acme.issue/a\    service uhttpd restart' acme-common/files/acme-notify.sh
sed -i "s/enabled '0'/enabled '1'/;s/token ''/token '$TUN30P_TOKEN'/" cloudflared/files/cloudflared.config