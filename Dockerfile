FROM node:20-alpine
WORKDIR /opt
COPY package.json ./
RUN npm install --legacy-peer-deps && \
    npm install ajv@^8 --legacy-peer-deps
COPY . .
ENTRYPOINT ["npm", "run", "start"]
