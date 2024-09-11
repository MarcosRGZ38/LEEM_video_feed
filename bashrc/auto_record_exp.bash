#!/bin/bash
# AFM CREAxLEEM

# Configuration:
CAM_WIDTH=1920
CAM_HEIGHT=1080
CAM_FPS=30
CAM_kBPS=10000
VIDEOT_S=60
AUTO_REMOVE_MIN=60
SAVE_DIR="/home/leem/video-exp/recordings/$(date +"%Y-%m-%dT%H-%M")/"
OUT_LOGS="/home/leem/video-exp/logs.txt"
CAM_LOGS="/home/leem/video-exp/cam-logs.txt"


# Available options (sudo libcamera-vid --list-cameras)
# OV5647: 640x480 58, 1296x972 43, 1920x1080 30, 2592x1944 15
# IMX219: 640x480 30, 1640x1232 30, 1920x1080 30, 3280x2464 30

# Under test:
# sudo libcamera-vid --width 1640 --height 1232 --framerate 60 -o output.raw


set +e
mkdir -p $SAVE_DIR

echo Script started at $(date) >> $OUT_LOGS
trap "echo 'Script terminated at $(date)' >> $OUT_LOGS; exit" SIGINT SIGTERM

while true
do
  OUT_FILE_MP4="${SAVE_DIR}$(date +"exp-vid-%Y-%m-%dT%H-%M-%S.mp4")"
  timeout $((VIDEOT_S+10))s libcamera-vid --codec libav --width $CAM_WIDTH --height $CAM_HEIGHT --framerate $CAM_FPS -->
  if [[ $? -ne 0 ]]; then
    echo "$(date): Error with libcamera-vid: See $CAM_LOGS for details" >> $OUT_LOGS
  fi

  sudo find "$SAVE_DIR" -type f -mmin +$AUTO_REMOVE_MIN -print -delete | while read file; do
    echo deleted file >> /dev/null
    #echo "Deleted file: $file" >> $OUT_LOGS
  done

  sleep 2
done
