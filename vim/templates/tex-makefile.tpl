PDF = <OUT>
_COMPILER = xelatex
_READER = evince

all: $(PDF)

$(PDF): %.pdf: %.tex
	$(_COMPILER) $<
	$(_READER) $@

.PHONY clean:
	ls -1 $(basename $(PDF))* | sed '/pdf\|tex/d' | xargs rm
