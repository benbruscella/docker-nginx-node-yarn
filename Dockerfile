FROM nginx:1.17.0

ARG YARN_VERSION=1.16.0-1
ARG NODE_VERSION=10.16.0-1nodesource1

RUN mkdir -p /www
WORKDIR /www
ADD . /www

# Update packages
RUN apt-get update

RUN apt-get install -yq curl apt-transport-https wget gnupg2 apt-utils

# Node & yarn packages
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# update cache
RUN apt-get update

# show available versions for node and yarn
RUN apt-cache madison nodejs
RUN apt-cache madison yarn

# node
RUN apt-get install -y nodejs=${NODE_VERSION}

# yarn
RUN apt-get install -y --no-install-recommends yarn=${YARN_VERSION}

RUN pwd

RUN ls -al /www

RUN node --version

RUN yarn --version
