FROM ubuntu

# Install depndencies
RUN apt-get update && apt-get install -y \
    unzip \
    wget \
    git \
    ruby2.3 \
    ruby2.3-dev \
    nodejs \
    nginx \
    build-essential

# Set proper locales
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen en_US.utf8 && \
    /usr/sbin/update-locale LANG=en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Build Octopress from github
RUN wget --no-check-certificate -O /tmp/octopress.zip https://github.com/imathis/octopress/archive/master.zip
RUN unzip /tmp/octopress.zip -d /srv/
RUN rm /tmp/octopress.zip

# Install Octopress dependencies
WORKDIR /srv/octopress-master
RUN gem install bundler
RUN bundle install

# Link config files to the mapped directory
RUN mkdir config
RUN mv Rakefile config/
RUN mv _config.yml config/
RUN ln -s config/Rakefile .
RUN ln -s config/_config.yml

# Install the default theme
RUN rake install

# Generate static page and link it to nginx webserver
# RUN rake generate
RUN rm -rf /var/www/html && \
    ln -s /srv/octopress-master/public/ /var/www/html

# Disable nginx daemon mode
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Expose default nginx port
EXPOSE 80

# Run Octopress
CMD rake generate && nginx
