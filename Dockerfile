# Builder phase
FROM node:13.8.0-alpine3.11 as builder

WORKDIR /app

ENV PATH /app/node_modules/.bin:$PATH

COPY package.json /app/package.json

RUN npm install

RUN npm install react-scripts@3.4.0 -g

COPY . .

RUN npm run build

#Run Phase
FROM nginx

COPY --from=builder /app/build usr/share/nginx/html