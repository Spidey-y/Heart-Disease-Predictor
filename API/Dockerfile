FROM python:3.10-slim
RUN pip install scikit-fuzzy numpy pandas matplotlib scikit-learn
WORKDIR /app
COPY app/requirements.txt .
RUN pip install -r requirements.txt
COPY ./app /app
EXPOSE 80
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
