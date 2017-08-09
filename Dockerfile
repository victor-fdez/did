FROM erlang:19-slim

ENV LANG=C.UTF-8
COPY ./did.tar.gz ./did.tar.gz
RUN tar -xvf ./did.tar.gz

ENTRYPOINT ["/bin/did"]
