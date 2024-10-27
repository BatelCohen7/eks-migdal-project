FROM python:3.9-slim

# Install Flask
RUN pip install flask

# Copy the app file into the container
COPY app.py /app/app.py

# Set the working directory
WORKDIR /app

# Expose the port that Flask will run on
EXPOSE 5000

# Command to run the app
CMD ["python", "app.py"]
