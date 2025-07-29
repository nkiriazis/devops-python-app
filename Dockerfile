FROM python:3.12-slim-bookworm

# Set the working directory to /app
WORKDIR /app

COPY requirements.txt requirements.txt

# Install Python dependencies
RUN pip install --no-cache-dirc-r requirements.txt

# Copy the application code
COPY . .

#Define the command to run the application
CMD ["python", "hello_world.py"]