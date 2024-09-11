gst-launch-1.0 -v filesrc location=/home/leem/Video.mp4 ! qtdemux ! h264parse ! rtph264pay config-interval=1 pt=96 ! gdppay ! tcpserversin versink host=192.168.0.11 port=8050
