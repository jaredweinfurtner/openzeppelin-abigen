# use the docker image for abigen as a base
FROM ethereum/client-go:alltools-v1.9.21

LABEL maintainer="jared@weinfurtner.io"

# the script that combines the calls for openzeppelin compilation and ethereum's abigen
COPY ./entrypoint.sh /

# change the work directory to the mounted volume
WORKDIR /sources

# openzeppelin compiler will try to create a directory: /.solc, so we create it and give permission
RUN mkdir /.solc && chmod 777 -R /.solc

# instead of using the solc compiler, we use the openzeppelin compiler which handles npm imported contracts
RUN apk update && \
    apk add --no-cache --update bash git openssh nodejs npm jq && \
    npm install -g @openzeppelin/cli

# the magic
ENTRYPOINT ["/entrypoint.sh"]
