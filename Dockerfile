FROM mediadepot/base:debian

#Create mopidy folder structure & set as volumes
RUN mkdir -p /srv/mopidy/app && \
	mkdir -p /srv/mopidy/config && \
	mkdir -p /srv/mopidy/data

WORKDIR /srv/mopidy/app

RUN apt-get update && apt-get install -y \
    wget python-pip && \
	wget -q -O - https://apt.mopidy.com/mopidy.gpg | apt-key add - && \
	wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/jessie.list && \

	apt-get install -y \
    mopidy && \

	pip install \
	pafy \
	Mopidy-GMusic \
	Mopidy-Mopify \
	Mopidy-Local-SQLite \
	Mopidy-SoundCloud \
	mopidy-notifier \
	Mopidy-Party && \

	rm -rf /var/lib/apt/lists/* && \
	apt-get purge -y \
	gcc-5 gcc g++-5 patch make xz-utils binutils cpp-5 libatomic1 '.*-dev$'

#start.sh will download the latest version of mopidy and run it.
ADD ./start.sh /srv/start.sh
RUN chmod u+x  /srv/start.sh

# Default configuration
COPY mopidy.conf /var/lib/mopidy/.config/mopidy/mopidy.conf

VOLUME ["/srv/mopidy/config", "/srv/mopidy/data"]
EXPOSE 8081
EXPOSE 6600
EXPOSE 6680

CMD ["/srv/start.sh"]

