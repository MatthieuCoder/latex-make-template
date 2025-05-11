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
	$(eval TMP := $(shell mktemp -d --suffix=$(TEMPSUFFIX)))
	@cp -r * $(TMP)/
	cd $(TMP)/; \
		$(TEX2PDF) $(TEXFLAGS) $<;
	@cp $(TMP)/$@ $@
	@$(RM) -r $(TMP)

# Rule that cleans all previous content
clean:
	@$(RM) *.pdf
	@$(RM) -r /tmp/*$(TEMPSUFFIX)

watch: watch.sh
	./watch.sh

.PHONY: all clean watch
