CC ?= gcc
CFLAGS ?= -std=c11 -Wall -Wextra -pedantic -O2
RELEASE_CFLAGS ?= -std=c11 -Wall -Wextra -pedantic -O3 -DNDEBUG
DEBUG_CFLAGS ?= -std=c11 -Wall -Wextra -pedantic -g -O0
DEPFLAGS ?= -MMD -MP
ARGS ?=

TARGET := QuizMaster
SOURCES := QuizMaster.c quiz.c quiz_data.c quiz_report.c quiz_support.c question.c dstring.c
OBJECTS := $(SOURCES:.c=.o)
DEPS := $(OBJECTS:.o=.d)

.PHONY: all clean run debug release help

all: $(TARGET)

help:
	@printf '%s\n' \
		'Targets:' \
		'  make            Build QuizMaster' \
		'  make run        Build and run QuizMaster' \
		'  make debug      Build with debug flags (-g -O0)' \
		'  make release    Build with release flags (-O3 -DNDEBUG)' \
		'  see README.md   Project overview, CSV format, and build notes' \
		'  make clean      Remove objects, deps, and binaries' \
		'' \
		'Variables:' \
		'  ARGS="..."      Extra arguments passed to ./QuizMaster when using make run'

$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) -o $@

%.o: %.c quiz.h quiz_internal.h question.h dstring.h
	$(CC) $(CFLAGS) $(DEPFLAGS) -c $< -o $@

run: $(TARGET)
	./$(TARGET) $(ARGS)

debug: CFLAGS := $(DEBUG_CFLAGS)
debug: clean $(TARGET)

release: CFLAGS := $(RELEASE_CFLAGS)
release: clean $(TARGET)

-include $(DEPS)

clean:
	rm -f $(OBJECTS) $(DEPS) $(TARGET) QuizMaster_new
