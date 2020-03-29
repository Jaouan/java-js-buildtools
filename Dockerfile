FROM jaouan/dind

ARG DEFAULT_JAVA=openjdk@1.13.0
ARG JABBA_VERSION=0.11.2
ARG NVM_VERSION=0.33.5
ARG YARN_VERSION=1.22.4

ENV JAVA_HOME=/jdk \
    PATH=$JAVA_HOME/bin:$PATH

# Jabba.
RUN curl -sL https://github.com/shyiko/jabba/raw/master/install.sh | bash \
    && . ~/.jabba/jabba.sh \
    && ln -s "/root/.jabba/jdk/${DEFAULT_JAVA}" /jdk \
# NVM.
    && curl -o /tmp/UnicodeData.txt --create-dirs http://unicode.org/Public/UNIDATA/UnicodeData.txt \
	&& chmod 777 /tmp/UnicodeData.txt \
	&& curl -o- https://raw.githubusercontent.com/creationix/nvm/v$NVM_VERSION/install.sh | bash \
# Yarn.
    && set -ex \
    && for key in \
    6A010C5166006599AA17F08146C2130DFD2497F5 \
    ; do \
    gpg --batch --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" || \
    gpg --batch --keyserver hkp://ipv4.pool.sks-keyservers.net --recv-keys "$key" || \
    gpg --batch --keyserver hkp://pgp.mit.edu:80 --recv-keys "$key" ; \
    done \
    && curl -fsSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" \
    && curl -fsSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz.asc" \
    && gpg --batch --verify yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz \
    && mkdir -p /opt \
    && tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/ \
    && ln -s /opt/yarn-v$YARN_VERSION/bin/yarn /usr/local/bin/yarn \
    && ln -s /opt/yarn-v$YARN_VERSION/bin/yarnpkg /usr/local/bin/yarnpkg \
    && rm yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz \
# Git.
    && echo "deb http://ftp.us.debian.org/debian testing main contrib non-free" >> /etc/apt/sources.list \
    && apt update \
    && apt install -y git \
# Subversion.
    && apt install -y subversion \
# Make.
    && apt install -y build-essential \
# Some editors.
    && apt install -y vim nano \
    && apt-get clean all