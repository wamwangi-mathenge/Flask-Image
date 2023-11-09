FROM ubuntu

RUN apt-get update
RUN apt-get install -y python3 python3-pip
RUN pip install flask

COPY app.py /opt/app.py
WORKDIR /opt/

ENTRYPOINT FLASK_APP=app.py flask run --host=0.0.0.0