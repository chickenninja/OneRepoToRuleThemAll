FROM debian

MAINTAINER Sean Davis

WORKDIR /tmp
EXPOSE 8038


RUN apt-get update
RUN apt-get install -y unzip hercules curl ranger vim links

RUN curl -o 3270.tgz https://netcologne.dl.sourceforge.net/project/x3270/x3270/3.6ga4/suite3270-3.6ga4-src.tgz
RUN curl -o turnkey.zip http://wotho.ethz.ch/tk4-/tk4-_v1.00_current.zip

RUN tar -xvf 3270.tgz
RUN unzip turnkey.zip

RUN apt-get install -y tmux
RUN echo 'alias bye="tmux kill-server"' >> ~/.bashrc
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
	update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8 

RUN apt-get install -y gcc libssl-dev m4 libncursesw5-dev make netcat

RUN cd suite3270-3.6 && ./configure --enable-c3270 && make

COPY mainframe-startup.sh /tmp

RUN chmod +x /tmp/mainframe-startup.sh
CMD tmux new -d -s mainframe && (/tmp/mainframe-startup.sh & (sleep 1 && tmux attach -t mainframe:0.0))
