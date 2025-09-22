FROM ubuntu:noble

WORKDIR /usr/src/app

COPY ./src .

ENV PATH="/usr/games:${PATH}"

RUN apt-get update \
 && apt-get install -y --no-install-recommends fortune-mod cowsay netcat-openbsd \
 && rm -rf /var/lib/apt/lists/*

RUN chmod +x wisecow.sh

CMD ["./wisecow.sh"]
