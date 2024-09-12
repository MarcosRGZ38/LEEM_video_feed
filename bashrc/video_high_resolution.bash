#!/bin/bash

# opciones disponibles
sudo libcamera-vid --list cameras

#configuraciones
CAM_WIDTH = 1640 
CAM_HEIGHT = 1232 
CAM_FPS = 60
CAM_kBPS = 10000 # variable dependiendo de la resolucion 
VIDEO_S = 60 
AUTO_REMOVE_MIN = 60 
SAVE_DIR = "/home/leem/video-exp/recordings/$(date + "%Y-%m-%dT-%H-%M")/"
OUT_LOGS = "/home/leem/video-exp/logs.txt"
CAM_LOGS = "/home/leem/video-exp/cam-logs.txt"

# Opcion con buena resolucion
sudo libcamera-vid --width $CAM_WIDTH --height $CAM_HEIGHT --framerate $CAM_FPS -o output.raw

set +e
mkdir -p $SAVE_DIR

echo Script started at $(date) >> $OUT_LOGS
trap "echo 'Script terminated at $(date)' >> $OUT_LOGS; exit" SIGINT SIGTERM

while true 
do
    OUT_FILE_RAW = "${$SAVE_DIR}$(date + "exp-vid-%Y-%m-%dT%H-%M-%S.raw")"
    timeout $((VIDEOT_S+10))s libcamera-vid --codec libav --width $CAM_WIDTH --height $CAM_HEIGHT --framerate $CAM_FPS -->

    if [[ $? -ne 0 ]]; then
        echo "$(date): Error with libcamera-vid: See $CAM_LOGS for details" >> $OUT_LOGS
    fi

    sudo find "$SAVE_DIR" -type f -mmin +$AUTO_REMOVE_MIN -print -delete | while read file do:
        echo deleted file >> /dev/null
        echo "Deleted file$file" >> $OUT_LOGS
    done 

done 