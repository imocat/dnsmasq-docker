#!/usr/bin/env sh

export DEFAULT_DNSMASQ="/etc/dnsmasq.d/default.conf"

if [ -f ${DEFAULT_DNSMASQ} ]
then
	unlink ${DEFAULT_DNSMASQ}
fi

# 挂载 ADDRESS_ 开头的环境变量
for env in $(env | grep "ADDRESS_" | awk -F '=' '{print $2}')
do
	echo "address=${env}" >> ${DEFAULT_DNSMASQ}
done

# 启动 DNSMASQ
/usr/local/sbin/dnsmasq -k