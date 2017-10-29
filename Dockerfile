FROM ubuntu:latest
MAINTAINER Oyvind Randa <Oyvind.Randa@gmail.com>

RUN apt-get clean -y && apt-get update -y
RUN apt-get install -yqq build-essential libbz2-dev libssl-dev libreadline-dev libsqlite3-dev tk-dev libpng-dev libfreetype6-dev curl git

RUN curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
ENV PYENV_ROOT /root/.pyenv
ENV PATH /root/.pyenv/shims:/root/.pyenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN pyenv install 3.6.3
RUN pyenv global 3.6.3

RUN pip  install -U pip
RUN python -m pip install -U cython
RUN python -m pip install -U numpy
RUN python -m pip install -U pandas
RUN python -m pip install -U scipy
RUN python -m pip install -U tensorflow
RUN python -m pip install -U jupyter
RUN python -m pip install -U matplotlib
RUN python -m pip install -U keras
RUN python -m pip install -U seaborn
RUN python -m pip install -U sklearn

RUN pyenv rehash

# Set up our notebook config.
COPY jupyter_notebook_config.py /root/.jupyter/

EXPOSE 8888
VOLUME ["/jupyter"]
ADD jupyter /jupyter
WORKDIR /jupyter
CMD [ "jupyter", "notebook", "--ip=0.0.0.0", "--allow-root" ]
