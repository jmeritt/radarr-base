FROM jmeritt/ubuntu-htpc

RUN apt-get update && apt-get install -y curl mediainfo sqlite3 apt-transport-https

RUN wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb &&\
	dpkg -i packages-microsoft-prod.deb &&\
	rm packages-microsoft-prod.deb

RUN apt-get update && \
  	apt-get install -y dotnet-sdk-7.0

USER htpc

#ENV VER=4.4.2.6956
ENV BRANCH=develop 

# master

RUN cd ~ &&\
	wget --content-disposition "http://radarr.servarr.com/v1/update/${BRANCH}/updatefile?os=linux&runtime=netcore&arch=x64" &&\
	tar -xvzf Radarr*.linux*.tar.gz && \
	rm Radarr*.linux*.tar.gz

EXPOSE 7878

ENV PROGRAMDATA /config

CMD ~/Radarr/Radarr /nobrowser /data=$PROGRAMDATA
