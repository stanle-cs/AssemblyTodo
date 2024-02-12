# message and graphics
MSG = "Todo App using Raylib, Raygui and ARM64 Assembly by Stan Le"
EDGE_TOP = $(shell echo $(MSG) | sed s/./¯/g)
EDGE_BOTTOM = $(shell echo $(MSG) | sed s/./_/g)

# various folder to be created/used
SRC_DIR := ./src
RESOURCE_DIR := $(SRC_DIR)/resource
LIB_DIR := ./lib
INC_DIR := $(SRC_DIR)/include
BUILD_DIR := ./build
OBJ_DIR := $(BUILD_DIR)/obj
BIN_DIR := ./bin

# tooling for MacOS using LLVM
#TOOLPATH := $(shell dirname $(shell xcodebuild -find clang))

# default tools
AS := as
LD := ld
# CC is not used at all as this is asm, but a good template
#CC := gcc

# find (recursive) all *.S files in SRC_DIR and collect them in SRC
SRC := $(shell find $(SRC_DIR) -name *.S)
# substitute all .S files with OBJ_DIR/*.o for object
OBJ := $(patsubst %.S, $(OBJ_DIR)/%.o, $(notdir $(SRC)))
# format the include string to pass to AS or CC
# this add the includes for INC_DIR and RESOURCE_DIR
INC := $(addprefix -I, $(INC_DIR) $(RESOURCE_DIR))

# executable declaration
EXE := app.exe
TARGET := $(BIN_DIR)/$(EXE)

# cflags to pass to CC
CFLAGS := `pkg-config --cflags raylib`
# various libraries to pass to LD or CC
# specific to MacOS
SYSLIB := -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path`
# raylib library
RAYLIB := `pkg-config --libs raylib`
# link the dynamic lib (MacOS specific)
DYNLIBS := -L$(LIB_DIR) $(LIB_DIR)/raygui.dynlib
LIBS := $(SYSLIB) $(RAYLIB) $(DYNLIBS)


# all these are fake targets, no real file should exists with their names
.PHONY: init build clean cleanall mkdir_build bear announcement
.DEFAULT: build

# box graphics
announcement:
	@echo ⎡$(EDGE_TOP)⎤
	@echo ⎜$(MSG)⎟
	@echo ⎣$(EDGE_BOTTOM)⎦
	make $(TARGET)

# compile exe
$(TARGET): $(OBJ)
	@echo "\ttarget: $@ prereq: $<"
	cp -p $(LIB_DIR)/raygui.dynlib $(BIN_DIR)/raygui.dynlib
	$(LD) $(OBJ) $(LIBS) -o $@
	@# link the raygui dynlib in the EXE to the folder where the exe file is located
	#install_name_tool -change 'raygui.dynlib' '@executable_path/raygui.dynlib' $(TARGET)

# compile object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.S
	@echo "\ttarget: $@ prereq: $<"
	$(AS) $(INC) $< -o $@

init:
	@mkdir -p $(SRC_DIR)
	@mkdir -p $(INC_DIR)
	@mkdir -p $(RESOURCE_DIR)
	@mkdir -p $(LIB_DIR)

mkdir_build:
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(OBJ_DIR)
	@mkdir -p $(BIN_DIR)

build: mkdir_build announcement $(TARGET)

clean:
	rm -rf $(OBJ) $(TARGET)

cleanall:
	rm -rf $(BUILD_DIR) $(BIN_DIR)

bear:
	bear -- make
