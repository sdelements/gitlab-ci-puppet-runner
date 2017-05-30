FROM ubuntu

# Install ruby and puppet-lint
RUN apt-get -y update && apt-get -y upgrade \
  && apt-get -y install ruby \
    ruby-bundler \
    ruby-dev \
    vagrant \
  && rm -rf /var/cache/apt/* \
  && gem install puppet puppet-lint rake serverspec --no-document

# Install python stuff and fabric
RUN apt-get -y install \
    build-essential libssl-dev libffi-dev python-dev \
    python python-pip \
    rsync \
  && pip install --upgrade pip \
  && pip install --upgrade virtualenv fabric \
  && pip install pysphere \
  && rm -rf /var/cache/apt/*

COPY Rakefile ./
COPY spec/ ./spec/
