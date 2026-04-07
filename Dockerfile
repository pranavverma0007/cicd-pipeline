FROM node:20-alpine
WORKDIR /opt
ADD . /opt
RUN npm install --legacy-peer-deps
ENTRYPOINT ["npm", "run", "start"]
