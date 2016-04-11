#!/bin/bash

shopt -s nocasematch; # regex case insensitive

LOG_PATH='/media/data/Misc/logs/transmission.log'
MOVIES_PATH='/media/data/Movies/'
SHOWS_PATH='/media/data/TVShows/'
SOURCE_PATH='/media/data/dl/'

test=$TR_TORRENT_NAME
testname=$(echo $test | sed 's/ /\./g')

echo '--------------------------------' >> $LOG_PATH
echo 'Processing File: '$test >> $LOG_PATH
echo 'Information: ' >> $LOG_FILE
echo '> Transmission version: '$TR_APP_VERSION >> $LOG_PATH
echo '> Time: ' $TR_TIME_LOCALTIME >> $LOG_PATH
echo '> Torrent directory: ' $TR_TORRENT_DIR >> $LOG_PATH
echo '> Torrent hash: ' $TR_TORRENT_HASH >> $LOG_PATH
echo '> Torrent ID: ' $TR_TORRENT_ID >> $LOG_PATH
echo '> Torrent Name: ' $TR_TORRENT_NAME >> $LOG_PATH
echo '--------------------------------' >> $LOG_PATH

 if [[ $test =~ ^(.+)\.S([0-9]+)E([0-9]+).*$ ]]; then
 	echo '>> Tv Show Found!'  >> $LOG_PATH
 	name=${BASH_REMATCH[1]}
 	season=${BASH_REMATCH[2]}
 	episode=${BASH_REMATCH[3]}
 	
 	name=$(echo $name | sed 's/\./ /g')
 	
 	echo 'Name: '$name >> $LOG_PATH
 	echo 'Season: '$season >> $LOG_PATH
 	echo 'Episode: '$episode >> $LOG_PATH
 	
 	directory="${SHOWS_PATH}${name}/Season ${season}/"
 	
 	echo '--------------------------------' >> $LOG_PATH
 	echo 'Creating directory (if needed):' $directory >> $LOG_PATH
 	
 	mkdir -p "$directory"
 	echo 'Moving file...' >> $LOG_PATH
 	mv "$SOURCE_PATH${test}" "$directory"
 	echo 'Done!' >> $LOG_PATH
 	echo '--------------------------------' >> $LOG_PATH
 	#move the file
 	
 	exit
 	
 else
 	
 	if [[ $test =~ ^(.+)\.[avi|mp4|mkv]*$ ]]; then
 		 
		echo '>> Movie Found!'  >> $LOG_PATH
 		directory="${MOVIES_PATH}${BASH_REMATCH[1]}/"
 	
 		echo '--------------------------------' >> $LOG_PATH
 		echo 'Creating directory (if needed):' $directory >> $LOG_PATH
 	
 		mkdir -p "$directory"
 		echo 'Moving file...' >> $LOG_PATH
 		mv "$SOURCE_PATH${test}" "$directory"
 		echo 'Done!' >> $LOG_PATH
 		echo '--------------------------------' >> $LOG_PATH 		
 		#move to movies directory
 		
 		exit
 	fi
 	
 	if [[ $testname =~ ^(.+)\.[DVDRip|DVDSCR|R5|TS|BRRip|BDRip|HDRip|BluRay].*$ ]]; then
 		echo '>> Movie Folder Found!' >> $LOG_PATH
 		newname=$(echo $test | sed 's/\./ /g')			
  		directory="${MOVIES_PATH}${newname}/" 
  		 	
 		echo '--------------------------------' >> $LOG_PATH
 		echo 'Creating directory:' $directory >> $LOG_PATH
  		
  		mkdir -p "$directory"
  		echo 'Moving file...' >> $LOG_PATH		
  		mv -f "${SOURCE_PATH}${test}"/*.avi "$directory"
  		mv -f "${SOURCE_PATH}${test}"/*.mkv "$directory"
	    mv -f "${SOURCE_PATH}${test}"/*.mp4 "$directory"
		  mv -f "${SOURCE_PATH}${test}"/*.srt "$directory"
  		echo 'Done!' >> $LOG_PATH		
  		echo '--------------------------------' >> $LOG_PATH		
 		exit
 	fi
 		
 	
 	echo 'Found another type of file...' >> $LOG_PATH
 	echo 'Copying to correspondent directory' >> $LOG_PATH
 	#move to other directory - TO BE IMPLEMENTED
 
 fi
