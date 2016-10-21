FROM node:4-onbuild

RUN apt-get update
RUN apt-get -y install iputils-ping netcat curl iproute2

RUN mkdir /app

COPY . /app

WORKDIR /app

RUN npm install

CMD ["npm", "start"]
