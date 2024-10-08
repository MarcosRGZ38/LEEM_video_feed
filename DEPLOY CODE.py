# DEPLOY CODE 
import RPi.GPIO as gpio 
import spidev

spi = spidev.SpiDev()
spi.open(1,1)

deploypin = 29

gpio.setmode(gpio.board)
gpio.setup(deploypin, gpio.OUT)

while True:
    acceleration = spi.readbytes(1)
    if acceleration < 0.2:
        gpio.setup(deploypin, gpio.HIGH)
    


