# docker binary from official image, node for HTTP server
FROM docker:24-cli AS docker
FROM node:20-alpine
COPY --from=docker /usr/local/bin/docker /usr/local/bin/docker
WORKDIR /app
COPY server.js .
ENV MININGCORE_CONTAINER=sert-umbrel-pool-miningcore_server_1
EXPOSE 8081
CMD ["node", "server.js"]
