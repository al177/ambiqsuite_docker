FROM ubuntu:22.04

RUN 	apt-get update && \
	apt-get -y upgrade && \
	apt-get install -y build-essential wget curl \
		gcc-arm-none-eabi binutils-arm-none-eabi udev
	
WORKDIR /tools
# Ignore - Segger needs to go through shrinkwrap license to download
#RUN wget https://www.segger.com/downloads/jlink/JLink_Linux_V782f_x86_64.deb && \
#	dpkg -i JLink_Linux_V782f_x86_64.deb
ADD JLink_Linux*x86_64.deb /tools/
RUN dpkg --unpack JLink_Linux*x86_64.deb &&\
	rm JLink_Linux*x86_64.deb &&\
	dpkg --configure jlink ;\
	rm /var/lib/dpkg/info/jlink.postinst -f &&\
	ls /var/lib/dpkg/info &&\
	apt install -y --fix-broken

WORKDIR /ambiq
ADD AmbiqSuite-R4-3-0.zip /ambiq


