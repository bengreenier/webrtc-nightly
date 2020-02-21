FROM debian:buster-20200130-slim
# Install deps
RUN apt-get update \
  && apt-get install -y \
  liblttng-ust0 \
  libkrb5-3 \
  zlib1g \
  libssl1.1 \
  libicu63 \
  curl \
  tar \
  dos2unix
# Add non-root user
RUN groupadd -r ghbuilder \
  && useradd ghbuilder -g ghbuilder \
  && mkdir -p /home/ghbuilder \
  && chown -R ghbuilder:ghbuilder /home/ghbuilder \
  && mkdir /home/ghbuilder/.config \
  && chown -R ghbuilder:ghbuilder /home/ghbuilder/.config
USER ghbuilder
WORKDIR /home/ghbuilder
# Install runner
RUN mkdir actions-runner \
  && cd actions-runner \
  && curl -O -L https://github.com/actions/runner/releases/download/v2.165.2/actions-runner-linux-x64-2.165.2.tar.gz \
  && tar xzf ./actions-runner-linux-x64-2.165.2.tar.gz

USER root
RUN actions-runner/bin/installdependencies.sh
USER ghbuilder

# Configure entrypoint
ENV GH_TOKEN ""
ENV GH_URL ""
ENTRYPOINT actions-runner/config.sh --token ${GH_TOKEN} --url ${GH_URL} && actions-runner/run.sh
