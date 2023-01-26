FROM node:18.12.0

WORKDIR /usr/src/javascript/app
RUN git clone https://github.com/vishnubob/wait-for-it.git

COPY ./package.json .
COPY ./package-lock.json .

COPY prisma ./prisma

RUN npm install

COPY . .

CMD ["npx", "ts-node", "index.ts"]
