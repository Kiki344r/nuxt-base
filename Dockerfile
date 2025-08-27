# Étape 1 : build de l'application
FROM node:lts-alpine as build-stage
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build
# Étape 2 : conteneur léger pour exécuter l'app
FROM node:lts-alpine

WORKDIR /app

COPY --from=build-stage /app/.output .output
COPY --from=build-stage /app/node_modules node_modules
COPY --from=build-stage /app/package.json .

ENV NITRO_PORT=80
EXPOSE 80

CMD ["node", ".output/server/index.mjs"]