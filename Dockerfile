FROM node:alpine3.18 as build
WORKDIR /app
COPY package.json .
RUN npx update-browserslist-db@latest && npm install -g npm@10.8.1
COPY . .
RUN npm run build


FROM nginx:1.23-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf *
COPY --from=build /app/build .
EXPOSE 80
ENTRYPOINT [ "nginx", "g", "daemon-off;" ]