#!/usr/bin/env sh

export DEFAULT_DNSMASQ="/etc/dnsmasq.d/default.conf"

# 挂载 ADDRESS_ 开头的环境变量
for env in $(env | grep "ADDRESS_" | awk -F '=' '{print $2}')
do
	echo "address=${env}" >> ${DEFAULT_DNSMASQ}
done

cat ${DEFAULT_DNSMASQ}

# 启动 DNSMASQ
/usr/local/sbin/dnsmasq -k