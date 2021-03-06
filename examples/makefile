# This is GNU-MAKE input file for building JANET examples.
# As a minimum, you should set JAVA_HOME environment variable prior to
# invoking this makefile

# USER DEFINED PARAMETERS

#JAVA_HOME=

JAVAC=javac
CC=gcc

## LINUX ##
#
#CFLAGS=-shared
#PLATFORM=linux

## SOLARIS ##
#
#CFLAGS=-G
#PLATFORM=solaris

JANET_HOME = ../

JANET=${JANET_HOME}/bin/janet -comments

#try to guess JAVA_HOME
JAVA_HOME ?= ${shell which java | sed 's/\/bin\/java//'}

#try to guess PLATFORM
PLATFORM ?= ${shell basename `find ${JAVA_HOME}/include/* -type d`}

#try to guess CFLAGS
CFLAGS ?= ${shell if test ${PLATFORM} = linux; then echo "-shared"; elif test ${PLATFORM} = solaris; then echo "-G"; else echo "-shared"; fi }

LIBRARY = libexamples.so

# END OF USER DEFINED PARAMETERS

.SUFFIXES:
.SUFFIXES: .class .java .janet $(SUFFIXES)


JANET_DIR=..

CFLAGS += -ansi \
          -I$(JAVA_HOME)/include -I$(JAVA_HOME)/include/$(PLATFORM) \
          -I$(JANET_HOME)/native/c/include

FILES=$(JANET_HOME)/native/c/janet.c \
      Arrays.c ArraysImpl.c Basic.c BasicImpl.c \
      Cast.c CastImpl.c ControlFlow.c ControlFlowImpl.c \
      Exceptions.c ExceptionsImpl.c HelloWorld.c HelloWorldImpl.c \
      Literals.c LiteralsImpl.c Operators.c OperatorsImpl.c \
      Strings.c StringsImpl.c Synchronized.c SynchronizedImpl.c

all: libexamples.so Main.class

clean:
	rm $(LIBRARY) *.c *.class *~ \
           Arrays.java Basic.java Cast.java ControlFlow.java \
	   Exceptions.java HelloWorld.java Literals.java Operators.java \
           Strings.java Synchronized.java

%.class: %.java
	$(JAVAC) *.java

%.java %.c %Impl.c: %.janet
	$(JANET) *.janet


$(LIBRARY): $(FILES)
	$(CC) $(CFLAGS) $^ -o $@

