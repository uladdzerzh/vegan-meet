FROM cirrusci/flutter:latest

RUN useradd -m -d /home/flutter flutter

RUN chown -R flutter:flutter /sdks/flutter

USER flutter

WORKDIR /app

COPY --chown=flutter:flutter pubspec.yaml .

RUN flutter pub get

COPY --chown=flutter:flutter . .

RUN flutter build web

USER root

EXPOSE 8080

FROM nginx:alpine

COPY --from=0 /app/build/web /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf
