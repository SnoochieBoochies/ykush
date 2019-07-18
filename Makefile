PROG_SOURCE = ykushcmd.cpp
SOURCE += commandParser.cpp
SOURCE += ykushxs/ykushxs.cpp
SOURCE += ykush/ykush.cpp
SOURCE += ykush2/ykush2.cpp
SOURCE += ykush3/ykush3.cpp
SOURCE += yk_usb_device.cpp
SOURCE += help/ykush_help.cpp
SOURCE += utils/command_parser.cpp
SOURCE += utils/string2val.cpp
SOURCE += usbhid/usbhid.cpp


SOURCE_FULL = $(addprefix src/, $(SOURCE))
PROG_SOURCE_FULL = $(addprefix src/, $(PROG_SOURCE))
OBJS = $(SOURCE_FULL:.cpp=.o)
PROG_OBJ = $(PROG_SOURCE_FULL:.cpp=.o)

CUR_PATH = $(shell echo $(PWD))
INCLUDEPATHS = $(addprefix -I$(CUR_PATH)/, $(dir $(SOURCE_FULL)))
LOADPATHS =
LIBS = -lusb-1.0
CPP = g++


ykushcmd : $(PROG_OBJ) $(OBJS)
	$(CPP) $(LOADPATHS) -o bin/$@ $(PROG_OBJ) $(OBJS) $(LIBS)

$(PROG_OBJ) :  %.o : %.cpp
	$(CPP) $(PREPROCESSOR_DEFS) $(INCLUDEPATHS) -c $< -o $@

$(OBJS) : %.o : %.cpp %.h
	$(CPP) $(PREPROCESSOR_DEFS) $(INCLUDEPATHS) -c $< -o $@

clean :
	rm -f bin/ykushcmd $(OBJS) $(PROG_OBJ)

