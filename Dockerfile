FROM node:10.20.1-alpine3.9

WORKDIR /app

# To handle 'not get uid/gid' error in alpine linux set unsafe-perm true

RUN apk update && apk upgrade \
    && npm config set unsafe-perm true \
    && npm install graphql-cli -g \
    && npm install prisma -g \
    && npm install nodemon -g \
    && npm install nexus-prisma-generate -g

COPY package.json ./

RUN yarn install

COPY . .

RUN chmod -R +x ./docker-scripts/

EXPOSE 4000

CMD ["./docker-scripts/entrypoint.sh"]