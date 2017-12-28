FROM debian

ENV ENTRYPOINT="docker-entrypoint.sh"
ENV TEMP_INSTALL_PACKAGES="gcc make unzip"

COPY ${ENTRYPOINT} /usr/bin/${ENTRYPOINT}
ADD https://github.com/infinet/dnsmasq/archive/fastlookup.zip /tmp

RUN date \
&& apt update -y \
&& apt install -y ${TEMP_INSTALL_PACKAGES} \
&& chmod +x /usr/bin/${ENTRYPOINT} \
&& mkdir /etc/dnsmasq.d \
&& cd /tmp \
&& sh -c 'if [ -f "fastlookup.zip" ];then unzip fastlookup.zip;fi' \
&& cd dnsmasq-fastlookup && make && make install \
&& apt remove -y ${TEMP_INSTALL_PACKAGES} \
&& rm -rf /tmp/* \
&& apt autoclean 

COPY dnsmasq.conf /etc/dnsmasq.conf

EXPOSE 53

ENTRYPOINT "/usr/bin/${ENTRYPOINT}"