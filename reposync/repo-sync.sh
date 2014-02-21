#!/bin/bash

VERSION=6.5

MIRROR=rsync://mirror.umd.edu/centos/$VERSION/
#MIRROR=rsync://mirror.itc.virginia.edu/centos/$VERSION/

DEST=/share/CentOS/$VERSION
LOCK=/var/lock/repo-sync_rsync

if [ -f $LOCK ]; then
	echo "Updates via rsync already running. Lock file present $LOCK"
	exit 0
fi
if [ -d $DEST ]; then 
	touch $LOCK 
	rsync -avSHP \
		--delete \
		--exclude "local*" \
		--exclude "isos" \
		--exclude "i386" \
		--exclude "SCL" \
		--exclude "centosplus" \
		--exclude "contrib" \
		--exclude "cr" \
		--exclude "extras" \
		--exclude "fasttrack" \
		--exclude "xen4" \
		$MIRROR $DEST
	/bin/rm -f $LOCK
else
	echo "Target directory $DEST not present."
fi
