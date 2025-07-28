# Étape 1 : build de l'app Angular
FROM node:18-alpine AS build
WORKDIR /app

# Copier package.json et package-lock.json (pour optimiser le cache Docker)
COPY package*.json ./
RUN npm install

# Copier tout le code source
COPY . .

# Builder l'application Angular en mode production
RUN npm run build --prod

# Étape 2 : servir l'app avec nginx
FROM nginx:alpine
COPY --from=build /app/dist/p1 /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
