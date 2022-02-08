FROM ubuntu:latest

RUN apt-get update && apt-get -y upgrade && apt-get -y install apt-cacher-ng

CMD ["/usr/sbin/apt-cacher-ng","foreground=1","port=3128","PassThroughPattern=.*","verboselog=2","debug=5"]
