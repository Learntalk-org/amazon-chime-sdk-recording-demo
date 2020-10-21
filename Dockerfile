# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN /usr/bin/apt-get update && \
	/usr/bin/apt-get install -y curl && \
	curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
	/usr/bin/apt-get update && \
	/usr/bin/apt-get upgrade -y && \
	/usr/bin/apt-get install -y nodejs pulseaudio xvfb ffmpeg xdotool unzip

RUN /usr/bin/apt-get update && \
    /usr/bin/apt-get install -y gnupg wget curl unzip --no-install-recommends && \
    wget -q -O https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb - && \
    /usr/bin/apt-get update -y && \
    /usr/bin/apt-get install -y ./google-chrome-stable_current_amd64.deb

COPY /recording /recording
WORKDIR /recording
RUN /usr/bin/npm install && \
	chmod +x /recording/run.sh && \
	chmod +x /recording/record.js

ENTRYPOINT ["/recording/run.sh"]