TEX := $(wildcard *.tex)
NAMES := $(TEX:.tex=.pdf)
TEX2PDF := xelatex
TEXFLAGS :=
TEMPSUFFIX := tex

# Target that matches all possible generated PDFs
all: $(NAMES)
$(NAMES): $(%:.pdf=.tex)

# Rule that builds the tex file in a temp directory and copies it
%.pdf: %.tex
	$(eval TEMP := $(shell mktemp -d --suffix=$(TEMPSUFFIX)))
	@cp -r * $(TEMP)/
	cd $(TEMP)/; \
		$(TEX2PDF) $(TEXFLAGS) $<;
	@cp $(TEMP)/$@ $@
	@$(RM) -r $(TEMP)

# Rule that cleans all previous content
clean:
	@$(RM) *.pdf
	@$(RM) -r /tmp/*$(TEMPSUFFIX)

watch: watch.sh
	./watch.sh

.PHONY: all clean watch
