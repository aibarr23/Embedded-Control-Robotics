# Create a test container for simpler testing
FROM registry.gitlab.com/docker-embedded/arduino-ide-on-raspberry-pi-4

# Install all Python3 requirements
COPY requirements.txt /
WORKDIR /
RUN apt-get update && apt-get install -y python3-pip
RUN pip3 install -r requirements.txt
RUN rm /requirements.txt