# SoapyRemote-airspyHF-Docker

Running SoapyRemote server with AirspyHF from Docker!

## Running server

```bash
$ docker run -t --device=/dev/bus/usb --net=host --rm acien101/soapyremote-airspyhf
```

Where:
* `-t --device=/dev/bus/usb`: Share USB device with Docker
* `--net=host`: Share host's network with the container. Disables network namespacing. Severe reduction of container isolation!

## Environment variables

* `SOAPY_REMOTE_IP_ADDRESS`: Specify IP address for SoapyrRemote server
* `SOAPY_REMOTE_PORT`: Specify port for SoapyRemote server

## References

* [hbaier/docker-soapysdr](https://github.com/hbaier/docker-soapysdr)