FROM debian:trixie-slim

RUN apt -y update && apt install -y nginx && apt install openssl -y

COPY ./tools/setupNG.sh /script.sh
RUN chmod +x /script.sh

CMD [ "/script.sh" ]