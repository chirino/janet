
# USER DEFINED PARAMETERS

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

JANET=../bin/janet -sourcecomments
JAVA_DIR = `which java | sed 's/\/bin\/java//'`
LIBRARY = libexamples.so

# END OF USER DEFINED PARAMETERS

.SUFFIXES:
.SUFFIXES: .class .java .janet $(SUFFIXES)


JANET_DIR=..

CFLAGS += -ansi \
          -I$(JAVA_DIR)/include -I$(JAVA_DIR)/include/$(PLATFORM) \
          -I$(JANET_DIR)/native/c/include

FILES=$(JANET_DIR)/native/c/janet.c \
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

