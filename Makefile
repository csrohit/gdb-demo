TARGET = prog

# BUILD_DIR = bin
# SRC_DIR = src
# SRCS    := $(wildcard $(SRC_DIR)/*.c)

INC_DIRS = include

# TARGET_EXEC := final_program

BUILD_DIR := build
SRC_DIR := src

# Find all the C and C++ files we want to compile
# Note the single quotes around the * expressions. Make will incorrectly expand these otherwise.
SRCS := $(shell find $(SRC_DIR) -name '*.cpp' -or -name '*.c' -or -name '*.s')

# String substitution for every C/C++ file.
# As an example, hello.cpp turns into ./build/hello.cpp.o
# OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)
OBJS    := $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(SRCS))

# INC_DIRS := $(shell find $(SRC_DIRS) -type d)
# Add a prefix to INC_DIRS. So moduleA would become -ImoduleA. GCC understands this -I flag
INC_FLAGS := $(addprefix -I,$(INC_DIRS))

CC := gcc
CFLAGS =  $(INC_FLAGS)
LDFLAGS = 

all: $(BUILD_DIR)/$(TARGET).out

$(BUILD_DIR)/${TARGET}.out: ${OBJS}
	$(CC) $(LDFLAGS) $^ -o $@


$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@if [ ! -d $(dir $@) ]; then mkdir -p $(dir $@); fi
	$(CC) $(CFLAGS) -c $< -o $@


clean:
	rm -rf $(BUILD_DIR)