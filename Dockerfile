# Etapa 1: compilar la app React
FROM node:16-alpine AS build
WORKDIR /app
ENV PUBLIC_URL=/
COPY package*.json ./
RUN npm install --legacy-peer-deps
COPY . .
RUN npm run build

# Etapa 2: servir el resultado con nginx
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]