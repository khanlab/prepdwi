FROM khanlab/neuroglia-dwi:latest
MAINTAINER <alik@robarts.ca>

RUN mkdir -p /opt/prepdwi
COPY . /opt/prepdwi

#add octave path
RUN echo addpath\(genpath\(\'/opt/prepdwi/octave\'\)\)\; >> /etc/octave.conf 
#install bc (bash calculator)
RUN apt-get install -y bc


ENV PATH /opt/prepdwi/bin:$PATH


ENTRYPOINT ["/opt/prepdwi/prepdwi"]
