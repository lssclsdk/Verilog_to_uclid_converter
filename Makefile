FLAGS = $(TOPFLAGS)
VERSION = -g
#LIB_TYPE = {static,shared}
LIB_TYPE = $(LIB)
CXX = $(COMPILER)

ifeq ($(LIB_TYPE),shared)
   LIB_EXT = so
else
   LIB_EXT = a
endif

OBJECTS = RTLElaboration.o
ifeq (,$(findstring "-DUSE_COMREAD",$(TOPFLAGS)))
  INCLUDE = commands
  LINKDIRS = commands
endif

INCLUDE += verilog
LINKDIRS += verilog

INCLUDE += vhdl
LINKDIRS += vhdl

INCLUDE += hdl_file_sort
LINKDIRS += hdl_file_sort

INCLUDE += hier_tree
LINKDIRS += hier_tree


INCLUDE += verilog_nl
LINKDIRS += verilog_nl





INCLUDE += database
LINKDIRS += database


INCLUDE += util containers
LINKDIRS += util containers

HEADERS =

COMPILEDIRS =

# 'libxnet' does not seem to be available on older SunOS5 systems.
# so use the finer set of many small .so files.
#
# -pg version needs -ldl if -xnet is used only.
#
ifeq ($(shell uname),Darwin)
  OS = mac
  EXTLIBS = $(STATIC) -ltcl -ldl -lm -lc
endif
ifeq ($(shell uname),SunOS)
   EXTLIBS = -ldl -lsocket -lnsl -lm -lc
   OS = solaris
endif
ifeq ($(shell uname),Linux)
   EXTLIBS = -ldl -lnsl -lm -lc -ltcl
   OS = linux
endif
LINKTARGET = add_module_and_port-$(OS)

# Link against -lz if compile flag VERIFIC_ENABLE_ZLIB is enabled (util/VerificSystem.h)
ifneq ($(strip $(shell grep -l "^\#define VERIFIC_ENABLE_ZLIB" ../../../util/VerificSystem.h)),)
    EXTLIBS += -lz
endif



##########################################################################
# Stable for each Makefile

#CFLAGS = -C relocation-model=static
CFLAGS = -no-pie
CFLAGS += -Wall
CFLAGS += $(FLAGS)

CC = gcc
ifeq ($(CXX),)
    CXX = g++
endif

##########################################################################
# Now the make rules

default: all

.SUFFIXES: .c .cpp .o

.cpp.o:
	$(CXX) -c -I. $(patsubst %,-I../../../%,$(INCLUDE)) $(VERSION) $(CFLAGS) $<

lib:
ifdef ($(COMPILEDIRS)
	for p in $(COMPILEDIRS); do \
		$(MAKE) -C ../$$p VERSION=$(VERSION)  lib ;\
	done
endif

$(LINKTARGET) : $(OBJECTS) lib
	$(CXX) $(VERSION) -o $(LINKTARGET) $(OBJECTS) $(patsubst %,../../../%/*-$(OS).$(LIB_EXT),$(LINKDIRS)) $(EXTLIBS)  $(CFLAGS)

all : $(LINKTARGET)

# Header file dependency : All my headers, and all included dir's headers
$(OBJECTS) : $(HEADERS) $(patsubst %,../../../%/*.h,$(INCLUDE))

clean:
	rm -f $(LINKTARGET) $(OBJECTS)
