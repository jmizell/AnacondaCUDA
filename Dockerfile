FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04
LABEL maintainer "Jeremy Mizell mizellj@ottercove.net"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 
ENV PATH /opt/conda/bin:/usr/local/bin:$PATH
ENV ANACONDA_VERSION 2018.12
ENV TINI_VERSION v0.18.0

RUN apt-get update --fix-missing \
    && apt-get install -y \
       build-essential\
       wget \
       unzip \
       bzip2 \
       ca-certificates \
       libglib2.0-0 \
       libxext6 \
       libsm6 \
       libxrender1 \
       git \
       mercurial \
       subversion

# Add Tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

# Install Conda
ADD https://repo.continuum.io/archive/Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh /root/anaconda.sh
RUN /bin/bash /root/anaconda.sh -b -p /opt/conda \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh
    
ENTRYPOINT ["/tini", "--"]
CMD [ "/bin/bash" ]
