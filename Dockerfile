FROM node:latest as build-stage

WORKDIR /app
COPY package*.json ./
RUN npm install
RUN npx ngcc --properties es2023 browser module main --first-only --create-ivy-entry-points
COPY . .
RUN npm run build

FROM nginx:stable
COPY --from=build-stage /app/dist/login-page/browser /usr/share/nginx/html
