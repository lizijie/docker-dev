# Dockerfile to build an image able to compile flashlight for a variety of
# platforms.
#
# > make docker

FROM centos:6.6
MAINTAINER "dfgdfg"

ENV WORKDIR /home

# Updating system.
RUN yum -y update && yum clean all

RUN yum install -y git \
	&& yum install -y subversion \
	&& yum install -y wget \
	&& yum install -y openssh-* \
	&& yum install -y make \
	&& yum install -y cmake \
	&& yum install -y groupinstall "Development tools"

RUN yum install glibc-devel.i686 \
	&& yum install -y libgcc.i686

RUN wget -O gcc-4.9.4.tar.gz http://gcc.parentingamerica.com/releases/gcc-4.9.4/gcc-4.9.4.tar.gz \
	&& tar -xvf gcc-4.9.4.tar.gz \
	&& cd gcc-4.9.4 && \
	&& ./contrib/download_prerequisites \
	&& ./configure --prefix=/usr/gcc-4.9.4 --enable-stage1-checking=release --enable-stage1-languages=c,c++,go \
	&& make -j 4 && make install \
