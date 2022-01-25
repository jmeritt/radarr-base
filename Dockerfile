FROM jmeritt/ubuntu-htpc

RUN apt-get update && apt-get install -y curl mediainfo sqlite3 apt-transport-https

RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb &&\
	dpkg -i packages-microsoft-prod.deb &&\
	rm packages-microsoft-prod.deb

RUN apt-get update && \
  	apt-get install -y dotnet-sdk-5.0

USER htpc

ENV VER=4.0.3.5879

RUN cd ~ &&\
	wget --content-disposition "https://github.com/Radarr/Radarr/releases/download/v${VER}/Radarr.develop.${VER}.linux-core-x64.tar.gz" &&\
	tar -xvzf Radarr*.linux*.tar.gz && \
	rm Radarr*.linux*.tar.gz

EXPOSE 7878

ENV PROGRAMDATA /config

CMD ~/Radarr/Radarr /nobrowser /data=$PROGRAMDATA
