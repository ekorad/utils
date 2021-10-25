.DEFAULT_GOAL := target

LIB_NAME := utils

SRC_DIR := src
INC_DIR := include
BIN_DIR := bin

INSTALL_INC_DIR := /usr/local/include
INSTALL_LIB_DIR := /usr/local/lib

SOURCES := $(addprefix $(SRC_DIR)/,*.cpp)
OBJ_NAME := $(addsuffix $(addprefix $(LIB_NAME),.so),lib)
HEADER_NAME := $(addprefix $(LIB_NAME),.h)

TARGET_OBJ := $(BIN_DIR)/$(OBJ_NAME)
TARGET_INC := $(INC_DIR)/$(HEADER_NAME)

INC_FLAGS := -I $(INC_DIR)
CXX_VER_FLAG := -std=c++17
DBG_FLAG :=
CXXFLAGS := $(INC_FLAGS) $(CXX_VER_FLAG)

.PHONY: all target clean install uninstall

all: target install

target: $(TARGET_OBJ)

$(TARGET_OBJ): $(BIN_DIR)/%.so: $(SOURCES)
	mkdir -p $(BIN_DIR)
	$(CXX) $(CXXFLAGS) -shared -o $@ -fPIC $(DBG_FLAG) $^

clean:
	rm -rf $(BIN_DIR)

install: target
	sudo install -d $(INSTALL_INC_DIR)
	sudo install -d $(INSTALL_LIB_DIR)
	sudo install -m644 $(TARGET_INC) $(INSTALL_INC_DIR)
	sudo install -m644 $(TARGET_OBJ) $(INSTALL_LIB_DIR)

uninstall:
	sudo $(RM) $(INSTALL_INC_DIR)/$(HEADER_NAME)
	sudo $(RM) $(INSTALL_LIB_DIR)/$(OBJ_NAME)