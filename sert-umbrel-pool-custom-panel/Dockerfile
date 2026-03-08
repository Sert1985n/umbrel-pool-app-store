FROM node:20-alpine
WORKDIR /app
COPY package.json .
RUN npm install --production
COPY server.js .
COPY public public
ENV COINS_FILE=/app/miningcore/coins.json
EXPOSE 8080
CMD ["node", "server.js"]
