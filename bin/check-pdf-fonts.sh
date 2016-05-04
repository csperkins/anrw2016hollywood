#!/bin/sh

pdffonts $1 > $2

nmf=`cat $2 | tail -n +3 | awk '{if ($(NF-4) != "yes") print $0}' | wc -l`

if [ $nmf -gt 0 ]; then \
  tput setaf 1 
  tput bold
  echo ""
  echo "WARNING: the following fonts are not embedded:"
  echo ""
  tput sgr0
  cat $2
  echo ""
  echo "Try running \"updmap --edit\" and setting \"pdftexDownloadBase14 true\""
  echo ""
  echo "================================================================================"
fi


