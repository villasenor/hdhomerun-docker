FROM ubuntu:latest

RUN apt update && apt install build-essential git -y

RUN git clone https://github.com/Silicondust/libhdhomerun.git

RUN cd libhdhomerun && make

