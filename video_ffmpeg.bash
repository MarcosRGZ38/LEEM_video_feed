ffmpeg -i Video.mp4 -f mpegts -codec:v libx264 -s 640x480 -b:v 150k -r 30 -an - | nc -l 8080
