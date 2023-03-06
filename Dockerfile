FROM node:14-alpine
  
# Install packages https://pkgs.alpinelinux.org/packages 
RUN apk --no-cache add \
    curl \
    yarn \
    git \
    bash

# npm uses SSH to get code from github.
# We use https instead to skip the manual ssh fingerprint acceptance.
RUN git config --global url."https://github.com/".insteadOf git@github.com: && \
    git config --global url."https://".insteadOf git:// && \
    git config --global url."https://".insteadOf ssh://

# Install merge-descriptors
RUN npm install --global merge-descriptors

# update globals
RUN npm update --global npm

RUN echo "IMAGE INFORMATION" > KTH_OS
RUN echo "Alpine version: `cat /etc/alpine-release `" >> KTH_OS
RUN echo "Build date: `date`" >> KTH_OS

RUN echo "IMAGE INFORMATION" > KTH_NODEJS
RUN echo "Based on:  node:14-alpine " >> KTH_NODEJS
RUN echo "Build date: `date`" >> KTH_NODEJS
RUN echo "Node: `node --version`" >> KTH_NODEJS
RUN echo "NPM: `npm --version`" >> KTH_NODEJS
RUN echo "Yarn: `yarn --version`" >> KTH_NODEJS
RUN echo "" >> KTH_NODEJS
RUN echo "--- Default global packages ---" >> KTH_NODEJS
RUN echo "`npm list -g --depth 0`" >> KTH_NODEJS

RUN cat KTH_OS
RUN cat KTH_NODEJS