# Imagen base con Node.js
FROM node:18-alpine

# Directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar package.json y package-lock.json
COPY package*.json ./

# Instalar dependencias
RUN npm install

# Copiar el resto de los archivos de la app
COPY . .

# Exponer el puerto
EXPOSE 3000

# Comando para arrancar la app
CMD ["npm", "start"]
