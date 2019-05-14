FROM golang:1.8

RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main\ndeb-src http://security.debian.org jessie/updates main" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y autoconf

ENV GOPATH /gopath
ENV CODIS  ${GOPATH}/src/github.com/CodisLabs/codis
ENV PATH   ${GOPATH}/bin:${PATH}:${CODIS}/bin
COPY . ${CODIS}

RUN make -C ${CODIS} distclean
RUN make -C ${CODIS} build-all

WORKDIR /codis
