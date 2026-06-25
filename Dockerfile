FROM python:3.13-slim

# تثبيت الحزم النظامية الأساسية
RUN apt-get update && apt-get install -y \
    git git-lfs ffmpeg libsm6 libxext6 cmake rsync libgl1 \
    && rm -rf /var/lib/apt/lists/* \
    && git lfs install

WORKDIR /app

# تثبيت أحدث الإصدارات المتوافقة من مكتبات Python
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir --upgrade \
        gradio \
        gradio_client \
        huggingface-hub \
        requests \
        yt-dlp \
        uvicorn \
        websockets \
        spaces \
        fastapi \
        audioop-lts \
        pydub \
        pydantic

# نسخ باقي ملفات المشروع (بما فيها app.py)
COPY . .

# منفذ التشغيل
EXPOSE 7860

CMD ["python", "app.py"]
