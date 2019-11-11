FROM jmeritt/debian-htpc

RUN apt install -y apt-transport-https dirmngr gnupg ca-certificates &&\
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF &&\
	echo "deb https://download.mono-project.com/repo/debian stable-buster main" | tee /etc/apt/sources.list.d/mono-official-stable.list && \
	apt update -y &&\
	apt install -y mono-devel 

RUN apt-get install -y curl libmediainfo-dev

USER htpc

RUN cd ~ && \
	curl -L -O $( curl -s https://api.github.com/repos/Radarr/Radarr/releases | grep linux.tar.gz | grep browser_download_url | head -1 | cut -d \" -f 4 ) && \
	tar -xvzf Radarr.*.linux.tar.gz && \
	rm Radarr.*.linux.tar.gz

EXPOSE 7878

ENV PROGRAMDATA /config

CMD mono --debug ~/Radarr/Radarr.exe /nobrowser /data=$PROGRAMDATA
