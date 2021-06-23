#Initial Dockerfile https://github.com/uphold/docker-litecoin-core/blob/master/0.18/Dockerfile
#Changed the initial base image since it had a lot of vulnerabilities to ubuntu:20.04 - not the most secured one but 21.04 had some issues on my local env regarding docker version.
#Scanned with Snyk - $docker scan --file Dockerfile ubuntu:20.04 - it's a tool that was included, does the job well, I guess similar with what Anchore does.
FROM ubuntu:20.04

#Run as user litecoin and install some dependency packages + gpg key public check - sometimes the server is sending request timeout, for me it worked fine couple of times.
#This SHA checksum can also be done by using a script but since litecoin.org offers a public GPG key I wanted to use the "Jedi" way - https://pgp.mit.edu/pks/lookup?op=get&search=0xFE3348877809386C

RUN useradd -r litecoin \
  && apt-get update -y \
  && apt-get install -y curl gnupg \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && set -ex \
#sometimes this part sends request timeout but it might be a firewall/proxy issue on localnetwork, for me it worked but on another laptop in a different network it didn't
  && for key in \
    B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    FE3348877809386C \
  ; do \
    gpg --no-tty --keyserver pgp.mit.edu --recv-keys "$key" || \
    gpg --no-tty --keyserver keyserver.pgp.com --recv-keys "$key" || \
    gpg --no-tty --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" || \
    gpg --no-tty --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" ; \
  done
#set env variable for litecoin version
ENV LITECOIN_VERSION=0.18.1
ENV LITECOIN_DATA=/home/litecoin/.litecoin
#at this step it downloads the tar.gz file of Litecoin and checks the gpg signature
RUN curl -SLO https://download.litecoin.org/litecoin-${LITECOIN_VERSION}/linux/litecoin-${LITECOIN_VERSION}-x86_64-linux-gnu.tar.gz \
  && curl -SLO https://download.litecoin.org/litecoin-${LITECOIN_VERSION}/linux/litecoin-${LITECOIN_VERSION}-linux-signatures.asc \
  && gpg --verify litecoin-${LITECOIN_VERSION}-linux-signatures.asc \
  && grep $(sha256sum litecoin-${LITECOIN_VERSION}-x86_64-linux-gnu.tar.gz | awk '{ print $1 }') litecoin-${LITECOIN_VERSION}-linux-signatures.asc \
  && tar --strip=2 -xzf *.tar.gz -C /usr/local/bin \
  && rm *.tar.gz

#volume to be used also in the next exercise
VOLUME ["/home/litecoin/.litecoin"]

#start app
CMD ["litecoind"]
