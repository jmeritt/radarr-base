FROM jmeritt/htpcarr

RUN apt-get install -y curl 

USER htpc

RUN cd ~ && \
	curl -L -O $( curl -s https://api.github.com/repos/Radarr/Radarr/releases | grep linux.tar.gz | grep browser_download_url | head -1 | cut -d \" -f 4 ) && \
	tar -xvzf Radarr.*.linux.tar.gz && \
	rm Radarr.*.linux.tar.gz

EXPOSE 7878

ENV PROGRAMDATA /config

CMD mono --debug ~/Radarr/Radarr.exe /nobrowser /data=$PROGRAMDATA
