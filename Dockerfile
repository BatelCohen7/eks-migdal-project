FROM python:3.9-slim

WORKDIR /app

COPY hello_world.py .

CMD ["python", "hello_world.py"]
