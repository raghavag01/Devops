# Use Ubuntu as the base image
FROM ubuntu:latest

# Install dependencies
RUN apt-get update && apt-get install -y python3 python3-pip python3-venv curl

# Create a virtual environment
RUN python3 -m venv /venv

# Set the environment to use the virtual environment
ENV PATH="/venv/bin:$PATH"

# Copy requirements.txt
COPY requirements.txt /app/requirements.txt

# Set the working directory to /app
WORKDIR /app

# Install Python dependencies in the virtual environment
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy the FastAPI app
COPY . /app

# Expose port 8000 for FastAPI
EXPOSE 8000

# Run the FastAPI app using uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
