TEX := $(wildcard *.tex)
NAMES := $(TEX:.tex=.pdf)

# Target that matches all possible generated PDFs
all: $(NAMES)
$(NAMES): $(%:.pdf=.tex)

# Rule that builds the tex file in a temp directory and copies it
%.pdf: %.tex
	$(eval TMP := $(shell mktemp -d --suffix=-sts-build))
	@cp -r * $(TMP)/
	cd $(TMP)/; \
		xelatex $<;
	@cp $(TMP)/$@ $@
	@rm -rf $(TMP)

# Rule that cleans all previous content
clean:
	@rm *.pdf
	@rm -r /tmp/*-sts-build
.PHONY: all clean