#base image
FROM python:3.8

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1  


COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt


RUN mkdir /huntly_backend
WORKDIR /huntly_backend
COPY ./huntly_backend /huntly_backend

