FROM ubuntu

# Install ruby and puppet-lint
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install ruby \
  ruby-bundler \
  ruby-dev
RUN rm -rf /var/cache/apt/*
RUN gem install puppet-lint --no-document

# Install python stuff and fabric
RUN apt-get -y install \
    python \
    python-pip \
    python-dev \
    build-essential \
  && pip install --upgrade pip \
  && pip install --upgrade virtualenv fabric \
  && rm -rf /var/cache/apt/*