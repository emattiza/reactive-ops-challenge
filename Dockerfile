FROM python:3-stretch
RUN pip install pipenv
WORKDIR /root/Projects
ADD ./app.py ./
ADD ./Pipfile.lock ./Pipfile ./
RUN pipenv install
RUN pipenv install --system --deploy
EXPOSE 8000
RUN pipenv check
RUN pipenv graph
CMD [ "pipenv", "run", "python", "app.py"]
