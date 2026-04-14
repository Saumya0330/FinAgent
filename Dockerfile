FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    libmagic1 \
    poppler-utils \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .
RUN mkdir -p sessions doc_cache audit_reports rules_chromadb temp_uploads rules_docs

EXPOSE 8000
CMD ["uvicorn", "Main:app", "--host", "0.0.0.0", "--port", "8000"]