FROM gcr.io/tensorflow/tensorflow:latest
MAINTAINER ryost <sato.ryo.so0@is.naist.jp>

#You need to add weights_SSD300.hdf5 to /ssd_keras/
#weights_SSD300.hdf5 is in https://mega.nz/#F!7RowVLCL!q3cEVRK9jyOSB9el3SssIA
RUN apt-get update && apt-get install -y wget unzip && apt-get install -y build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev

RUN mkdir /opencv
WORKDIR /opencv
RUN wget https://github.com/Itseez/opencv/archive/3.1.0.zip && unzip 3.1.0.zip && mkdir -p /opencv/opencv-3.1.0/build
WORKDIR /opencv/opencv-3.1.0/build
RUN cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_IPP=ON ..
RUN make -j7
RUN make install
WORKDIR /
#RUN git clone https://github.com/rykov8/ssd_keras.git

#RUN python -c 'import keras; print(keras.__version__)'
#UN pip uninstall keras
RUN pip install keras==1.2.2

CMD [ "/bin/bash" ]

#git clone https://github.com/ryo-st/weight.git
#cd weight/
#cp weights_SSD300.hdf5 ../ssd_keras/
#cd ..
#git rm weight/
#cd weight/
#git rm -r .
#cd weight/
#cd ..
#git rm -r weight/
#rm weight/
#rm -r weight/
#cd ssd_keras/
#cd ..