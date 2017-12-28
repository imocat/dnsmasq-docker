FROM centos:7

ENV ENTRYPOINT="docker-entrypoint.sh"
ENV TEMP_INSTALL_PACKAGES="gcc make unzip"

COPY ${ENTRYPOINT} /usr/bin/${ENTRYPOINT}
ADD https://github.com/infinet/dnsmasq/archive/fastlookup.zip /tmp

RUN date \
&& yum update -y \
&& yum install -y bind-utils net-tools \
&& yum install -y ${TEMP_INSTALL_PACKAGES} \
&& chmod +x /usr/bin/${ENTRYPOINT} \
&& mkdir /etc/dnsmasq.d \
&& cd /tmp \
&& sh -c 'if [ -f "fastlookup.zip" ];then unzip fastlookup.zip;fi' \
&& cd dnsmasq-fastlookup && make && make install \
&& yum remove -y ${TEMP_INSTALL_PACKAGES} \
&& rm -rf /tmp/* \
&& yum clean all

COPY dnsmasq.conf /etc/dnsmasq.conf

EXPOSE 53/udp

ENTRYPOINT "/usr/bin/${ENTRYPOINT}"