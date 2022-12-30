SRC_DIR := ./src
RESOURCE_DIR := ./resource
LIB_DIR := ./lib
INC_DIR := ./include $(RESOURCE_DIR)
BUILD_DIR := ./build
OBJ_DIR := $(BUILD_DIR)/obj
BIN_DIR := ./bin

#TOOLPATH := $(shell dirname $(shell xcodebuild -find clang))
AS := as
LD := ld
CC := gcc-12

SRC := $(shell find $(SRC_DIR) -name *.S)
OBJ := $(patsubst %.S, $(OBJ_DIR)/%.o, $(notdir $(SRC)))
INC := $(addprefix -I, $(INC_DIR))

EXE := app.exe
TARGET := $(BIN_DIR)/$(EXE)


CFLAGS := `pkg-config --cflags raylib`
SYSLIB := -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path`
RAYLIB := `pkg-config --libs raylib`
DYNLIBS := -L$(LIB_DIR) $(LIB_DIR)/raygui.dynlib
LIBS := $(SYSLIB) $(RAYLIB) $(DYNLIBS)


.DEFAULT: build
$(TARGET): $(OBJ)
	@echo "\ttarget: $@ prereq: $<"
	$(LD) $(OBJ) $(LIBS) -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.S
	@echo "\ttarget: $@ prereq: $<"
	$(AS) $< -o $@

.PHONY: build cleanall clean mkdir_build bear

build: mkdir_build $(TARGET)
mkdir_build:
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(OBJ_DIR)
	@mkdir -p $(BIN_DIR)
clean:
	rm -rf $(OBJ) $(TARGET)
cleanall:
	rm -rf $(BUILD_DIR) $(BIN_DIR)
bear:
	bear -- make
