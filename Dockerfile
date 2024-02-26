FROM python:3.9-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    software-properties-common \
    git \
    && rm -rf /var/lib/apt/lists/*

# install pip3 packages specified in requirements.txt file
COPY requirements.txt .
RUN pip3 install -r requirements.txt

# Copy app_run code into image
RUN mkdir -p /app/app_run
COPY app_run /app/app_run/
COPY .streamlit /app/.streamlit/

EXPOSE 8501

HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

ENTRYPOINT ["streamlit", "run", "app_run/Home.py", "--server.port=80", "--server.address=0.0.0.0"]
# # Set default commands (used for testing as the default command will be set on AWS Batch Job definition)
# CMD ["bash", "-c", "python3 app_run/scripts/test_bstream_csv.py"]