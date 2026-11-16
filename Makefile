ifeq ($(OS),Windows_NT)
    DETECTED_OS := Windows
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        DETECTED_OS := Linux
    endif
    ifeq ($(UNAME_S),Darwin)
        DETECTED_OS := macOS
    endif
endif

CC      = gcc
CFLAGS  = -Iheader -O3 -Wall -Wextra -march=native 
LDFLAGS =
LDLIBS  = -lm

ifeq ($(DETECTED_OS),macOS)

    LIBOMP_PREFIX := $(shell brew --prefix libomp 2>/dev/null)
    ifneq ($(LIBOMP_PREFIX),)
        CFLAGS  += -Xpreprocessor -fopenmp -I$(LIBOMP_PREFIX)/include
        LDFLAGS += -L$(LIBOMP_PREFIX)/lib
        LDLIBS  += -lomp
    else
        CFLAGS  += -Xpreprocessor -fopenmp
        LDLIBS  += -lomp
    endif
else
    CFLAGS += -fopenmp
endif

SIEVE_DEPS = SuraSieveV5.c
GOLD_DEPS = $(SIEVE_DEPS) algorithms/Goldbach/pairFinder.c
COMET_DEPS = $(GOLD_DEPS) algorithms/Goldbach/cometMaker.c
BITSIEVE_DEPS = SSieveBitArray.c
BITSIEVEV2_DEPS = algorithms/Sieves/BitSieves/BitSieveV2.c
BITSIEVEV3_DEPS = algorithms/Sieves/BitSieves/BitSieveV3.c

all: bitSieve primeGen pairFind comet

bitSieve: bitSieveMain.c $(BITSIEVE_DEPS)
	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@ $(LDLIBS)

primeGen: primeGenMain.c $(SIEVE_DEPS)
	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@ $(LDLIBS)

# pairFind: main/pairFindMain.c $(GOLD_DEPS)
# 	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@ $(LDLIBS)

# comet: main/cometMain.c $(COMET_DEPS)
# 	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@ $(LDLIBS)

clean:
	rm -f primeGen bitSieve

.PHONY: clean
