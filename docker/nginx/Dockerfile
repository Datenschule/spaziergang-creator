FROM nginx

RUN apt-get update -qq && apt-get -y install apache2-utils \
    && apt-get clean \
    && rm -f /var/lib/apt/lists/*_*

ENV RAILS_ROOT /var/www/spaziergang_creator

WORKDIR $RAILS_ROOT

RUN mkdir log

COPY public public/

COPY docker/nginx/app.conf /tmp/docker_example.nginx

RUN envsubst '$RAILS_ROOT' < /tmp/docker_example.nginx > /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]
