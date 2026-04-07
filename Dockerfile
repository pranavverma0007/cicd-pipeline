FROM node:20-alpine
WORKDIR /opt
COPY package.json ./
RUN npm install --legacy-peer-deps
COPY . .
ENTRYPOINT ["npm", "run", "start"]
