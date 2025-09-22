FROM ubuntu:noble

WORKDIR /usr/src/app

COPY ./src .

ENV PATH="$PATH:/usr/games"

RUN apt update && apt install fortune-mod cowsay netcat-openbsd -y

CMD ["./wisecow.sh"]