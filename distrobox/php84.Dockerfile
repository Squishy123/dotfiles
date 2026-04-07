FROM ubuntu:24.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    software-properties-common \
    ca-certificates \
    gnupg \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

RUN add-apt-repository -y ppa:ondrej/php && \
    apt-get update

RUN apt-get install -y \
    php8.4-cli \
    php8.4-common \
    php8.4-mbstring \
    php8.4-xml \
    php8.4-curl \
    php8.4-zip \
    php8.4-gd \
    php8.4-intl \
    php8.4-bcmath \
    php8.4-pdo \
    php8.4-mysql \
    php8.4-sqlite3 \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 24   

RUN mkdir -p "$NVM_DIR" \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash \
    && . "$NVM_DIR/nvm.sh" \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default \
    && ln -s $NVM_DIR/versions/node/$(nvm version)/bin/node /usr/local/bin/node \
    && ln -s $NVM_DIR/versions/node/$(nvm version)/bin/npm /usr/local/bin/npm \
    && ln -s $NVM_DIR/versions/node/$(nvm version)/bin/npx /usr/local/bin/npx \
    && chmod -R a+x $NVM_DIR

# Make NVM and Composer global bins available in any bash session (login or non-login)
RUN echo 'export NVM_DIR=/usr/local/nvm' >> /etc/bash.bashrc && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> /etc/bash.bashrc && \
    echo 'export NVM_DIR=/usr/local/nvm' >> /etc/environment && \
    echo 'export PATH="$HOME/.config/composer/vendor/bin:$PATH"' >> /etc/bash.bashrc

RUN php --version && composer --version && node --version && npm --version

WORKDIR /app

CMD ["bash"]
