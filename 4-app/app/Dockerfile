FROM python:3.9-alpine

EXPOSE 8080
ENV NAME=Docker

WORKDIR /app

COPY . .
RUN pip install -r requirements.txt

ENTRYPOINT [ "gunicorn", "-b", "0.0.0.0:8080", "app:app" ]
