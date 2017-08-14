FIND ?=find
DIRNAME ?=dirname

TOTEST ?=$(shell $(FIND) ./examples -name Makefile -exec $(DIRNAME) \{\} \;)
$(info $(TOTEST))
all: build

squeeky: $(TOTEST)
	@for i in $? ; do (cd $$i && make BOARD=teensy:avr:teensy30:usb=serial,speed=96,opt=o1std,keys=en-us squeeky && make BOARD=teensy:avr:teensy31:usb=serial,speed=96,opt=o1std,keys=en-us squeeky && make BOARD=teensy:avr:teensy36:usb=serial,speed=96,opt=o1std,keys=en-us squeeky) ; done
	@echo FULL cleanup done

clean: $(TOTEST)
	@for i in $? ; do (cd $$i && make BOARD=teensy:avr:teensy30:usb=serial,speed=96,opt=o1std,keys=en-us clean && make BOARD=teensy:avr:teensy31:usb=serial,speed=96,opt=o1std,keys=en-us clean && make BOARD=teensy:avr:teensy36:usb=serial,speed=96,opt=o1std,keys=en-us clean) ; done
	@echo Cleanup done

build: $(TOTEST)
	@for i in $? ; do (cd $$i && make BOARD=teensy:avr:teensy30:usb=serial,speed=96,opt=o1std,keys=en-us all && make BOARD=teensy:avr:teensy31:usb=serial,speed=96,opt=o1std,keys=en-us all && make BOARD=teensy:avr:teensy36:usb=serial,speed=96,opt=o1std,keys=en-us all) ; done
	@echo all targets built

monitor:
	cu -l /dev/ttyUSB0 -s 115200 || cu -l /dev/ttyACM0 -s 115200 || cu -l /dev/ttyUSB1 -s 115200 || cu -l /dev/ttyACM1 -s 115200

.PHONY: all clean build squeeky monitor
