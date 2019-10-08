FROM python:3.7-alpine
MAINTAINER Humble-Goat.

ENV PYTHONUNBUFFERED 1

# Install dependencies
COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
      gcc libc-dev linux-headers postgresql-dev
RUN python -m pip install pipenv
RUN pipenv install -r /requirements.txt
RUN apk del .tmp-build-deps

# Setup directory structure
RUN mkdir /liquid_brain
WORKDIR /liquid_brain
COPY ./liquid_brain/ /liquid_brain

RUN adduser -D user
USER user
