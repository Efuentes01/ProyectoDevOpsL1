# 🚀 ProyectoDevOpsL1

Un proyecto DevOps que demuestra un pipeline completo de **CI/CD** usando Docker y un **GitHub Actions runner self-hosted**.  
El objetivo es automatizar el ciclo completo: **build → push → deploy** sin intervención manual.

---

## 📦 Stack Tecnológico

- **Node.js + Express**: Backend simple
- **Docker**: Contenerización de la aplicación
- **GitHub Actions**: Automatización CI/CD
- **Self-hosted Runner**: Para ejecutar el CD en la máquina local

---

## 🛠️ Estructura de Workflows

### ✅ CI Pipeline
📄 `.github/workflows/ci.yml`
- **Disparo:** Push a rama `main`
- **Acciones:**
  - Construye la imagen Docker
  - La sube a Docker Hub como `efuentes01/proyectodevopsl1:latest`

---

### ✅ CD Pipeline
📄 `.github/workflows/cd.yml`
- **Disparo:** Cuando el CI Pipeline termina exitoso
- **Acciones:**
  - Ejecuta en un runner self-hosted
  - Detiene y borra el contenedor viejo (si existe)
  - Hace pull de la nueva imagen
  - Corre el contenedor actualizado en `localhost:3000`

---

## 🔐 Configuración

Antes de ejecutar los pipelines asegúrate de:

### 1️⃣ Configurar Secrets en GitHub
Ve a **Settings → Secrets and variables → Actions** en tu repositorio y agrega:

| Secret Name          | Descripción                                        |
|----------------------|----------------------------------------------------|
| `DOCKER_USERNAME`    | Usuario de Docker Hub                              |
| `DOCKER_PASSWORD`    | Contraseña o Access Token de Docker Hub            |

🔑 Estos secrets se usan para hacer login en Docker Hub durante los pipelines.

---

### 2️⃣ Actualizar rutas de imágenes Docker
Si cambias tu usuario de Docker Hub o el nombre del repo, actualiza las rutas en:

- **CI Pipeline (`ci.yml`):**
  ```yaml
  docker build -t <your-username>/proyectodevopsl1:latest .
  docker push <your-username>/proyectodevopsl1:latest
  ```

- **CD Pipeline (`cd.yml`):**
  ```yaml
  docker pull ${{ secrets.DOCKER_USERNAME }}/proyectodevopsl1:latest
  docker run -d --name proyectodevopsl1 -p 3000:3000 ${{ secrets.DOCKER_USERNAME }}/proyectodevopsl1:latest
  ```

---

### 3️⃣ Runner self-hosted
Configura un **runner self-hosted** en la máquina que realizará el deploy.  
Sigue la guía oficial de [GitHub Actions Runners](https://docs.github.com/en/actions/hosting-your-own-runners/about-self-hosted-runners).

✅ **Recuerda:** Todos los paths y variables están pensados para este proyecto. Cambia lo necesario si usas otro repo o estructura.

---

## 🏃‍♂️ Cómo ejecutar localmente

### 1️⃣ Clonar repositorio
```bash
git clone https://github.com/efuentes01/ProyectoDevOpsL1.git
cd ProyectoDevOpsL1
```

### 2️⃣ Configurar runner self-hosted
Sigue la guía oficial de [GitHub Actions Runners](https://docs.github.com/en/actions/hosting-your-own-runners/about-self-hosted-runners) para levantar un runner en tu máquina local.

### 3️⃣ Instalar Docker
Asegúrate de tener [Docker Desktop](https://www.docker.com/products/docker-desktop) instalado y configurado.

---

## 🚀 Flujo de despliegue

1. Haz cambios en el código.
2. Commit & Push a `main`:
   ```bash
   git add .
   git commit -m "feat: nuevo cambio 🚀"
   git push origin main
   ```
3. GitHub Actions ejecuta:
   - **CI Pipeline** → Build & Push
   - **CD Pipeline** → Pull & Deploy en tu máquina local
4. App actualizada en [http://localhost:3000](http://localhost:3000) 🎉

---

## 🐳 Comandos útiles

Ver contenedores en ejecución:
```bash
docker ps
```

Ver logs del contenedor:
```bash
docker logs -f proyectodevopsl1
```

Eliminar contenedor (si es necesario):
```bash
docker stop proyectodevopsl1
docker rm proyectodevopsl1
```

---

## 🌟 Próximos pasos

- [ ] Añadir `docker-compose.yml` para manejar múltiples servicios (app + DB)
- [ ] Configurar staging y producción
- [ ] Tests automáticos en CI
- [ ] Deploy a servidor en la nube (AWS/Azure)

---

## 👨‍💻 Autor

[Eliud Fuentes](https://github.com/efuentes01)
