FROM node:15.0.1-buster as builder
WORKDIR '/app'
COPY  ./package.json ./
RUN npm install -g gatsby-cli
RUN npm install
COPY . .
RUN gatsby build

FROM nginx
EXPOSE 8000
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build /usr/share/nginx/html