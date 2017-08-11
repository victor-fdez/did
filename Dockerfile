FROM debian:jessie

ENV LANG=C.UTF-8

COPY ./did.tar.gz ./did.tar.gz

RUN apt-get update && \
    apt-get install -y ca-certificates openssl && \
    tar -xvf ./did.tar.gz && \
    rm ./did.tar.gz 

ENTRYPOINT ["/bin/did", "foreground"]
