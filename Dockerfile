# *** BEGIN common Dockerfile commands, to improve caching
# *** Please copy from Dockerfile.common
FROM python:3.7.9-buster
SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get dist-upgrade -y

# improve docker layer caching by installing requirements.txt early & separately
# COPY requirements.txt /app/requirements.txt
WORKDIR /app

COPY . /app

RUN python -m pip install -U pip

RUN python -m pip install jupyter jupyterlab

RUN python -m venv /opt/venv

RUN . /opt/venv/bin/activate && \
    python -m pip install --upgrade pip && \
    python -m pip install -r requirements.txt && \
    python -m ipykernel install --user --name=doorstead

ENV PYTHONPATH=.

CMD ["jupyter", "lab", "--port", "8889", "--ip", "0.0.0.0", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]
