.DEFAULT_GOAL := target

LIBNAME := utils

SRCDIR := src
INCDIR := include
BINDIR := bin

INSTALLINCDIR := /usr/local/include
INSTALLLIBDIR := /usr/local/lib

SOURCES := $(addprefix $(SRCDIR)/,*.cpp)
OBJNAME := $(addsuffix $(addprefix $(LIBNAME),.so),lib)
HEADERNAME := $(addprefix $(LIBNAME),.h)

LIBOBJ := $(BINDIR)/$(OBJNAME)
LIBINC := $(INCDIR)/$(HEADERNAME)

INCFLAGS := -I $(INCDIR)
CXXVERFLAG := -std=c++17
DBG :=
CXXFLAGS := $(INCFLAGS) $(CXXVERFLAG)

.PHONY: all target clean install uninstall

all: target install

target: $(BINDIR) $(LIBOBJ)

$(LIBOBJ): $(BINDIR)/%.so: $(SOURCES)
	$(CXX) $(CXXFLAGS) -shared -o $@ -fPIC $(DBG) $^

$(BINDIR):
	mkdir -p $(BINDIR)

clean:
	rm -rf $(BINDIR)

install: target
	sudo install -d $(INSTALLINCDIR)
	sudo install -d $(INSTALLLIBDIR)
	sudo install -m644 $(LIBINC) $(INSTALLINCDIR)
	sudo install -m644 $(LIBOBJ) $(INSTALLLIBDIR)

uninstall:
	sudo $(RM) $(INSTALLINCDIR)/$(HEADERNAME)
	sudo $(RM) $(INSTALLLIBDIR)/$(OBJNAME)