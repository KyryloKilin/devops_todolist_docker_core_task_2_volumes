ARG PY_BASE=3.11-slim
FROM python:${PY_BASE} AS build
ENV PYTHONUNBUFFERED=1
WORKDIR /app
COPY requirements.txt .
RUN pip install --upgrade pip && pip wheel --wheel-dir=/wheels -r requirements.txt

FROM python:${PY_BASE}
ENV PYTHONUNBUFFERED=1
WORKDIR /app
COPY --from=build /wheels /wheels
RUN pip install --no-index --find-links=/wheels /wheels/*
COPY . .

ARG DB_HOST=127.0.0.1
ENV DB_HOST=${DB_HOST}

RUN python manage.py migrate --noinput

EXPOSE 8080
CMD ["python", "manage.py", "runserver", "0.0.0.0:8080"]
