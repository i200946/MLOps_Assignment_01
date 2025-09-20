# ----------------------------
# Dockerfile for Flask app
# ----------------------------
FROM python:3.10-slim

# Prevent Python from writing .pyc files and buffer issues
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install system deps (kept minimal)
RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential && \
    rm -rf /var/lib/apt/lists/*

# Copy and install Python deps
COPY requirements.txt .
RUN python -m pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Expose Flask port
EXPOSE 5000

# Use gunicorn to run the Flask app (production-ready)
CMD ["gunicorn", "-w", "2", "-b", "0.0.0.0:5000", "app.app:app"]

