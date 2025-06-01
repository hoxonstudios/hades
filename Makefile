default: build

SRC = $(wildcard src/*.c)
OBJ = $(patsubst src/%.c, obj/%.o, $(SRC))
DEPS = $(patsubst obj/%.o, obj/%.d, $(OBJ))

bin/hades.exe: $(OBJ) | bin
	clang -O3 $(OBJ) -o $@

-include $(DEPS)

obj/%.o: src/%.c | obj
	clang -O3 -Isrc -Iinc -c $< -o $@ -MMD

bin:
	mkdir bin

obj:
	mkdir obj

# Commands
build: bin/hades.exe

start: build
	bin/hades

clean:
	rm -r -fo bin
	rm -r -fo obj
