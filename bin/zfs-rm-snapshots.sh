for snapshot in `zfs list -H -t snapshot | cut -f 1`
do
	echo $snapshot
	zfs destroy $snapshot
done
