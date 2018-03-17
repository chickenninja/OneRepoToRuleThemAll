FROM debian:jessie

RUN apt-get update && \
    apt-get install -y locales && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8 && \
    apt-get remove -y locales

ENV LANG C.UTF-8
WORKDIR /root

RUN apt-get update && apt-get install -y curl bzip2 libsdl1.2-dev libgtk2.0-0 libsdl-image1.2 libsdl-ttf2.0-0 vim links nethack-console
RUN curl http://www.bay12games.com/dwarves/df_44_07_linux.tar.bz2 -o df.tar.bz2

RUN bunzip2 df.tar.bz2
RUN tar -xvf df.tar
RUN rm df.tar

RUN sed -i -e 's/\[PRINT_MODE:2D]/\[PRINT_MODE:TEXT]/g' df_linux/data/init/init.txt
RUN sed -i -e 's/\[SOUND:YES]/\[SOUND:NO]/g' df_linux/data/init/init.txt
RUN sed -i -e 's/\[INTRO:YES]/\[INTRO:NO]/g' df_linux/data/init/init.txt

# Default to dwarf fortress, but could also play nethack
CMD ./df_linux/df
