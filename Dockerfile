FROM node:8
EXPOSE 3000

WORKDIR /app

COPY . /app/

RUN npm i

CMD ["npm", "start"]
