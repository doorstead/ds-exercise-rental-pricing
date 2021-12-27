FROM python:3.7.9-buster

# set bash as default shell
SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get dist-upgrade -y

WORKDIR /app

COPY . /app

# upgrade pip
RUN python -m pip install -U pip

RUN python -m pip install jupyter jupyterlab

# create virtual environment
RUN python -m venv /opt/venv

# https://pythonspeed.com/articles/activate-virtualenv-dockerfile/
# install requirements in the virtual env
RUN . /opt/venv/bin/activate && \
    python -m pip install --upgrade pip && \
    python -m pip install -r requirements.txt && \
    python -m ipykernel install --user --name=doorstead

ENV PYTHONPATH=.

CMD ["jupyter", "lab", "--port", "8889", "--ip", "0.0.0.0", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]
