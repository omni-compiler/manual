# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
SPHINXPROJ    = manual
SOURCEDIR     = .
BUILDDIR      = _build

all: html-ja html-en
html-ja:
	$(SPHINXBUILD) -a -b html -d _build/doctrees ./ja /home/omni/public_html/manual/ja
html-en:
	$(SPHINXBUILD) -a -b html -d _build/doctrees ./en /home/omni/public_html/manual/en

local:
	sphinx-build -a -b html -d _build/doctrees ./ja ./local-build

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
#%: Makefile
#	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
