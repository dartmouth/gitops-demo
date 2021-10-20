FROM openjdk:11

RUN set -x \
  && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
  && apt-get update \
  && apt-get install -y libltdl7 python3-pip unzip openssl libssl-dev \
  && pip install virtualenv \
  && pip3 install virtualenv

WORKDIR /
ENV JENKINS_JARFILE "/usr/local/bin/slave.jar"
COPY docker-entrypoint.sh /usr/local/bin/
COPY slave.jar /usr/local/bin/
RUN ln -s /usr/local/bin/docker-entrypoint.sh / # backwards compat
ENTRYPOINT ["/docker-entrypoint.sh"]
