#!/bin/bash


base=$HOME/dvdrip
device='/dev/dvd'
vbitrate="1200"
abitrate=256
lameopts="br=$abitrate:cbr"
#endpos="-endpos 300"
msglevel="-quiet -msglevel all=5"
#alang="-alang en -slang en"
alang=""
aid="-aid 160"
#aid=""
filters="-vf pp=lb -forcedsubsonly -sid 0"
# -force-avi-aspect 1.33333"
# -forcedsubsonly -sid 2"
# -forcedsubsonly -sid 0"
af=""
#"-af volnorm=2"
threads=2

args=("$@")
project=$1
mode=$2

mkdir -m 0775 -p $base/$project/tmp
mkdir -p $base/$project/avi
mkdir -p $base/$project/vob
case $mode in
r)
	# rip
	for (( i = 2 ; i < ${#args[@]} ; i++ ))
	do
		title=${args[$i]}

		echo "Ripping title $title"
		
		rm -f $base/$project/vob/$project-$title.vob

		tccat -t dvd -T $title,-1,1 -i $device -d 2 > $base/$project/vob/$title.vob
	#	tccat -t dvd -T $title,-1,1 -i $device -d 2 | \
	#		tcextract -a 0 -x ac3 -t vob | \
	#		tcdecode -x ac3 > $base/$project/vob/$title.vob
			#tcscan -x pcm
			
#dvdrip-splitpipe -f $base/$project/tmp/$project-$title-nav.log 1024 $base/$project/vob/$title/$project vob  | \
	done
;;
t)
	let total=${#args[@]}-2
	# transcode
	for (( i = 2 ; i < ${#args[@]} ; i++ ))
	do
		title=${args[$i]}
		let cur=$i-1
		echo "================ Transcoding title $title ($cur of $total) ============="

		cd $base/$project/tmp

		echo "Pass 1 of 2 - $title ($cur of $total)"

		command="mencoder $base/$project/vob/$title.vob \
			-ffourcc DIVX -ovc lavc -lavcopts threads=$threads:vcodec=mpeg4:vbitrate=$vbitrate:mpeg_quant:gmc:vpass=1 \
			$af -oac mp3lame -lameopts $lameopts:aq=9 $alang $aid $filters \
			-o /dev/null $endpos $msglevel "
		echo $command
		echo
		eval $command

		echo "Pass 2 of 2 - $title ($cur of $total)"

		command="mencoder  $base/$project/vob/$title.vob \
			-ffourcc DIVX -ovc lavc -lavcopts threads=$threads:vcodec=mpeg4:vbitrate=$vbitrate:mpeg_quant:gmc:vpass=2 \
			$af -oac mp3lame -lameopts $lameopts $alang $aid $filters \
			-o $base/$project/avi/$project-$title.avi $endpos $msglevel "
		echo $command
		echo
		eval $command

	done
;;
dvdnav)
	let total=${#args[@]}-2
	# transcode
	for (( i = 2 ; i < ${#args[@]} ; i++ ))
	do
		title=${args[$i]}
		let cur=$i-1
		echo "================ Transcoding title $title ($cur of $total) ============="

		cd $base/$project/tmp

		echo "Pass 1 of 2 - $title ($cur of $total)"

		command="mencoder -dvd-device $device dvdnav://$title -nocache \
			-ffourcc DIVX -ovc lavc -lavcopts threads=$threads:vcodec=mpeg4:vbitrate=$vbitrate:mpeg_quant:gmc:vpass=1 \
			$af -oac mp3lame -lameopts $lameopts:aq=9 $alang $aid $filters \
			-o /dev/null $endpos $msglevel "
		echo $command
		echo
		eval $command

		echo "Pass 2 of 2 - $title ($cur of $total)"

		command="mencoder -dvd-device $device dvdnav://$title -nocache \
			-ffourcc DIVX -ovc lavc -lavcopts threads=$threads:vcodec=mpeg4:vbitrate=$vbitrate:mpeg_quant:gmc:vpass=2 \
			$af -oac mp3lame -lameopts $lameopts $alang $aid $filters \
			-o $base/$project/avi/$project-$title.avi $endpos $msglevel "
		echo $command
		echo
		eval $command

	done
;;
dvdnav-single)
	let total=${#args[@]}-2
	# transcode
	for (( i = 2 ; i < ${#args[@]} ; i++ ))
	do
		title=${args[$i]}
		let cur=$i-1
		echo "================ Transcoding title $title ($cur of $total) ============="

		cd $base/$project/tmp

		echo "Single pass encoding - $title ($cur of $total)"

		command="mencoder dvdnav://$title -nocache \
			-ffourcc DIVX -ovc lavc -lavcopts threads=$threads:vcodec=mpeg4:vbitrate=$vbitrate:mpeg_quant:gmc \
			$af -oac mp3lame -lameopts $lameopts $alang $aid $filters \
			-o $base/$project/avi/$project-$title.avi $endpos $msglevel "
		echo $command
		echo
		eval $command

	done
;;
*)
	echo "Usage: $0 <project name> [r|t|dvdnav|dvdnav-single] <title list>"
;;
esac

##
## extra options
##

# audio gain
# -s 3.578 

# clip
# -Y 4,4,4,4 

# resize
# -B 1,11,8 

# input frame rate
#-f 24,1
