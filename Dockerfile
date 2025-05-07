# Use a Python 3.10 slim image that is compatible with TF 2.10.0
FROM python:3.10-slim

# Set environment variables to avoid .pyc files and enable real-time logs
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6 \
    && rm -rf /var/lib/apt/lists/*

# Copy requirement files and install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy all project files
COPY . .

# Expose the port used by Gunicorn
EXPOSE 10000

# Command to run the app using Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:10000", "app:app"]
