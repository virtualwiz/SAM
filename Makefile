OBJS = reciter.o sam.o render.o main.o debug.o

CC = gcc
OPEN = xdg-open

# libsdl present
# CFLAGS =  -Wall -Os -DUSESDL `sdl-config --cflags`
# LFLAGS = `sdl-config --libs`

AFNAME = speech.wav

# no libsdl present
CFLAGS =  -Wall -Os
LFLAGS =

sam: $(OBJS)
	$(CC) -o sam $(OBJS) $(LFLAGS)

%.o: src/%.c
	$(CC) $(CFLAGS) -c $<

package:
	tar -cvzf sam.tar.gz README.md Makefile sing src/

clean:
	rm -f *.o
	rm -f $(AFNAME)

archive:
	rm -f sam_windows.zip
	cd ..; zip SAM/sam_windows.zip	SAM/sam.exe SAM/SDL.dll SAM/README.md SAM/demos/*.bat

say:
	@read -p "What should I say? > " sentence; \
	./sam -wav $(AFNAME) $$sentence
	$(OPEN) $(AFNAME)
