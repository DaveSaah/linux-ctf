FROM debian:stable-slim

RUN apt-get update && apt-get install vim -y

RUN useradd -m -s /bin/bash linux

USER linux

WORKDIR /home/linux

COPY ./setup/bashrc .bashrc
COPY ./bin/glow /bin/

CMD [ "/bin/bash" ]
