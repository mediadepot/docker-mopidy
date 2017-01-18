#!/usr/bin/env sh

#run the default config script
sh /srv/config.sh

#chown the mopidy directory by the new user
chown mediadepot:mediadepot -R /srv/mopidy

# run mopidy
su -c "mopidy" mediadepot
