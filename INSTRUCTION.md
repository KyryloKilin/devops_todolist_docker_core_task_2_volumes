# Django-Todolist + MySQL (Docker)

## Образы на Docker Hub
- MySQL: https://hub.docker.com/r/mcisb/mysql-local/tags
- App:   https://hub.docker.com/r/mcisb/todoapp/tags

## 1) Запуск MySQL с volume

```bash
docker network create todo-net || true
sudo mkdir -p /srv/mysql-data
sudo chown -R 999:999 /srv/mysql-data

docker run -d --name mysql-local \
  --network todo-net \
  -p 3306:3306 \
  -v /srv/mysql-data:/var/lib/mysql \
  <dockerhub_user>/mysql-local:1.0.0
