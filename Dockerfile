FROM python:3.9-slim

WORKDIR /app
COPY . /app
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    software-properties-common \
    git \
    && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/dianepaul/data-visualization-tool .
RUN pip install -r requirements.txt
EXPOSE 8503
HEALTHCHECK CMD curl --fail http://localhost:8503/_stcore/health
ENTRYPOINT ["streamlit", "run", "app.py", "--server.port=8503", "--server.address=0.0.0.0"]