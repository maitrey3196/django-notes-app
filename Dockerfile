FROM python:3.9

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3-dev \
    default-libmysqlclient-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app/backend

# Copy and install Python dependencies
COPY requirements.txt /app/backend/
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy the rest of your application code
COPY . /app/backend/

# Expose port 8000
EXPOSE 8000
RUN python manage.py migrate
RUN python manage.py makemigrations

# final line keeps the container alive
CMD python /app/backend/manage.py runserver 0.0.0.0:8000
