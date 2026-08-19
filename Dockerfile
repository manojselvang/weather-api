_____________________________________________________
# Stage - 1 (Builder Stage)
_____________________________________________________
FROM python:3.9-slim AS builder

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir --prefix=/app/deps -r requirements.txt

____________________________________________________
# Stage - 2 (Runtime Stage)
____________________________________________________

FROM python:3.9-slim

WORKDIR /app

COPY --from=builder /app/deps /app/deps
COPY app.py .

ENV PYTHONPATH=/app/deps/lib/python3.9/site-packages

EXPOSE 5000

CMD ["python", "app.py"]
