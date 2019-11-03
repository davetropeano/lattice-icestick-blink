all: $(notdir $(CURDIR)).bin

%.bin: %.txt
	icepack $< $@

%.txt: %.blif
	arachne-pnr -q -d 1k --post-place-blif $*.place.blif -o $@ -p $(notdir $(CURDIR)).pcf $<

%.blif: %.v
	yosys -q -p "synth_ice40 -top main -blif $@" $<

upload: $(notdir $(CURDIR)).bin
	iceprog $<

clean:
	rm -f *.bin *.txt *.blif *.rpt

.PRECIOUS: %.bin %.txt %.blif 
.PHONY: all explain install clean

