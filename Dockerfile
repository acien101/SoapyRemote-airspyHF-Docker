FROM ubuntu:18.04

RUN apt-get update

RUN apt-get install -y software-properties-common
RUN apt-get install -y build-essential cmake libusb-1.0-0-dev pkg-config wget git

# Install SoapySDR dependencies
RUN apt-get install -y avahi-daemon libavahi-client-dev
RUN mkdir -p /var/run/dbus

###### Install last version of SoapySDR
WORKDIR /tmp
RUN git clone https://github.com/pothosware/SoapySDR.git
RUN mkdir /tmp/SoapySDR/build
WORKDIR /tmp/SoapySDR/build
RUN cmake ..
RUN make
RUN make install
RUN ldconfig

## Install Soapyremote
WORKDIR /tmp
RUN git clone https://github.com/pothosware/SoapyRemote.git
RUN mkdir /tmp/SoapyRemote/build
WORKDIR /tmp/SoapyRemote/build
RUN cmake ..
RUN make
RUN make install
RUN ldconfig


## Install airspy hf driver
# <https://github.com/airspy/airspyhf>
WORKDIR /tmp
RUN wget https://github.com/airspy/airspyhf/archive/1.6.8.tar.gz
RUN tar -xf 1.6.8.tar.gz
WORKDIR airspyhf-1.6.8
RUN mkdir build
WORKDIR build
RUN cmake ../ -DINSTALL_UDEV_RULES=ON
RUN make
RUN make install
RUN ldconfig
RUN rm -rf *

## Soapy SDR plugin for AirspyHF+
# <https://github.com/pothosware/SoapyAirspyHF/wiki>
WORKDIR /tmp
RUN git clone https://github.com/pothosware/SoapyAirspyHF.git
WORKDIR SoapyAirspyHF
RUN mkdir build
WORKDIR build
RUN cmake ..
RUN make
RUN make install

COPY ./soapysdr-helper.sh /usr/local/bin
RUN chmod 744 /usr/local/bin/soapysdr-helper.sh

RUN apt-get install -y supervisor

RUN mkdir -p /var/log/supervisor
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]

