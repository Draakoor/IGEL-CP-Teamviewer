#!/bin/sh

ACTION="custompart-teamviewer_${1}"

# mount point path
MP=$(get custom_partition.mountpoint)
# custom partition path
CP="${MP}/teamviewer"
# output to systemlog with ID amd tag
LOGGER="logger -it ${ACTION}"

echo "Starting" | $LOGGER

wait_processes()
{
	WAIT_RET=1
	for pid in $(fuser -m -M "$MP" 2>/dev/null) ; do
		if [ "$pid" != "$$" ] ; then
			WAIT_RET=0
			break
		fi
	done
	
	return $WAIT_RET
}

kill_processes()
{
	for pid in $(fuser -m -M "$MP" 2>/dev/null) ; do
		if [ "$pid" != "$$" ] ; then
			kill -9 "$pid" 2>/dev/null
		fi
	done
	
	return 0
}

case "$1" in
init)
	mkdir -p /userhome/.config /userhome/.local/share
	chown -R user:users ${CP}/userhome /userhome/.config /userhome/.local
	cp /custom/teamviewer/opt/teamviewer/tv_bin/script/teamviewerd.service /lib/systemd/system/teamviewerd.service
	sleep 2
	systemctl start teamviewerd.service
	
	# Linking files and folders on proper path
	find "${CP}" | while read LINE
	do
		DEST=$(echo -n "${LINE}" | sed -e "s|${CP}||g")
		if [ ! -z "${DEST}" -a ! -e "${DEST}" ]; then
			# Remove the last slash, if it is a dir
			[ -d $LINE ] && DEST=$(echo "${DEST}" | sed -e "s/\/$//g") | $LOGGER
			if [ ! -z "${DEST}" ]; then
				ln -sv "${LINE}" "${DEST}" | $LOGGER
			fi
		fi
	done
;;
stop)
	systemctl stop teamviewerd.service
	sleep 1
	i=0
	wait_processes
	RET=$?
	while [ "$RET" = "0" ] ; do
		if [ "$i" = "3" ] ; then
			kill_processes
			sleep 2
			break
		fi
		sleep 1
		i=$((i+1))
		wait_processes
		RET=$?
	done
;;
esac

echo "Finished" | $LOGGER

exit 0
