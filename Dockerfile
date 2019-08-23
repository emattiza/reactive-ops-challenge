FROM python:3.7-alpine
ENV PYTHONFAULTHANDLER=1 \
  PYTHONUNBUFFERED=1 \
  PYTHONHASHSEED=random \
  PIP_NO_CACHE_DIR=off \
  PIP_DISABLE_PIP_VERSION_CHECK=on \
  PIP_DEFAULT_TIMEOUT=100 \
  PIPENV_HIDE_EMOJIS=true \
  PIPENV_COLORBLIND=true \
  PIPENV_NOSPIN=true \
  PIPENV_DOTENV_LOCATION=config/.env

RUN apk --no-cache add \
     bash \
     build-base \
     curl \
     gcc \
     gettext \
     git \
     libffi-dev \
     linux-headers \
     musl-dev \
     postgresql-dev \
     tini

RUN pip install pipenv

COPY . /code
WORKDIR /code

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x "/entrypoint.sh"

RUN pipenv install --deploy --ignore-pipfile
EXPOSE 8000

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]

