FROM openjdk:11

RUN set -x \
  && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
  && apt update \
  && apt install -y libltdl7 python3-pip unzip openssl libssl-dev \
  && pip install virtualenv \
  && pip3 install virtualenv

# Required for Mac, insall Docker command line tools
RUN apt install -y apt-transport-https \
 && curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
 && echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \
 && apt update \
 && apt install -y docker-ce-cli

WORKDIR /
ENV JENKINS_JARFILE "/usr/local/bin/agent.jar"
COPY docker-entrypoint.sh /usr/local/bin/
COPY agent.jar /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
