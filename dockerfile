FROM node:18-alpine

WORKDIR /parse-server

RUN apk add --no-cache python3 make g++ gcc gettext

COPY package*.json ./
COPY parse-config.json ./

RUN npm install -g npm@latest && \
    npm install && \
    npm install -g parse-server @parse/s3-files-adapter && \
    npm cache clean --force

COPY . .

EXPOSE 1337

CMD ["/bin/sh", "-c", "envsubst < /parse-server/parse-config.json > /parse-server/parse-config-env.json && parse-server /parse-server/parse-config-env.json"]
