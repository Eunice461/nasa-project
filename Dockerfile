FROM node:lts-alpine

WORKDIR /app

COPY package*.json ./

COPY client/package*.json client/
RUN npm run install-client --only=production

COPY server/package*.json server/
RUN npm run install-server --only=production

COPY client/ client/
RUN npm run build --prefix client

COPY server/ server/
RUN npm start --prefix server

USER node

CMD [ "npm", "start", "--prefix", "server", "src" ]

EXPOSE 8000