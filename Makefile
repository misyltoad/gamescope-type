CFLAGS = -g -O3 -Wall -Wextra -Wno-unused-parameter
WAYLAND_SCANNER = $(shell pkg-config --variable=wayland_scanner wayland-scanner)

deps = wayland-client
depflags = $(shell pkg-config $(deps) --cflags --libs)

protocol_files = gamescope-input-method-protocol.h gamescope-input-method-protocol.c

all: gamescope-type

gamescope-type: main.c $(protocol_files)
	$(CC) $(CFLAGS) -o $@ $^ $(depflags)

gamescope-input-method-protocol.h: protocol/gamescope-input-method.xml
	$(WAYLAND_SCANNER) client-header $< $@
gamescope-input-method-protocol.c: protocol/gamescope-input-method.xml
	$(WAYLAND_SCANNER) private-code $< $@

clean:
	$(RM) gamescope-type $(protocol_files)
