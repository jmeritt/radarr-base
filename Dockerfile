FROM jmeritt/ubuntu-htpc

RUN apt-get update && apt-get install -y curl mediainfo sqlite3


USER htpc

RUN cd ~ &&\
	wget --content-disposition 'http://radarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=x64' &&\
	tar -xvzf Radarr*.linux*.tar.gz && \
	rm Radarr*.linux*.tar.gz

EXPOSE 7878

ENV PROGRAMDATA /config

CMD ~/Radarr/Radarr /nobrowser /data=$PROGRAMDATA
