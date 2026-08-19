# Docker Multistage Build Demo - Weather API

A simple hands-on project to understand how **Docker Multi-Stage Builds** can make container images smaller and cleaner.

## What this project does

This project takes a small Python application and builds it using two Docker stages:

* **Builder stage** – installs the Python dependencies.
* **Runtime stage** – starts from a clean Python image and copies only what is needed to run the application.

The goal is to avoid carrying unnecessary build files, caches, and dependencies into the final image.

## Project Structure

```text
.
├── app.py
├── requirements.txt
├── Dockerfile
├── .dockerignore
└── README.md
```

## Why Multi-Stage Builds?

A normal Docker build can leave unnecessary files and tools in the final image.

With a multi-stage build:

```text
Builder Image
    │
    │ Install dependencies
    ▼
/app/deps
    │
    │ Copy only required files
    ▼
Runtime Image
    │
    ├── Python runtime
    ├── Application
    └── Dependencies
```

This keeps the final image smaller and avoids shipping things that are only required during the build.

## Build the Image

From the project directory:

```bash
docker build -t python-multistage-demo .
```

## Run the Container

```bash
docker run -p 5000:5000 python-multistage-demo
```

The application should then be available on:

```text
http://localhost:5000
```

## .dockerignore

`.dockerignore` to prevent unnecessary files from being sent to the Docker daemon during the build.

```text
logs/
.git/
```

Useful to ignore large log files or Git history present inside application directory (/app).

## What I Learned

This project helped me understand a few important Docker concepts:

* How Docker build stages work
* Why `COPY --from=builder` is used
* How dependencies can be installed separately from the runtime image
* Why `.dockerignore` matters
* How reducing the build context can speed up Docker builds
* How to keep the final container image cleaner and smaller

## Conclusion

**Don't put everything you need to build an application into the final image.**

Build what you need in one stage, then copy only the required artifacts into a clean runtime image.

That is the main idea behind Docker Multi-Stage Builds.
