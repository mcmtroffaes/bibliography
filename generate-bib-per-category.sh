#!/bin/bash

[ -z "$1" ] && echo "Specify an author name." && exit

bib2bib -s year -s month -r -ob publications.bib -c "author : \"$1\" or (editor : \"$1\" and (\$type = \"PROCEEDINGS\" or \$type = \"BOOK\"))" all.bib
bib2bib -ob journals.bib -c "\$type = \"ARTICLE\"" publications.bib
bib2bib -ob conferences.bib -c "\$type = \"INPROCEEDINGS\"" publications.bib
bib2bib -ob unpublished.bib -c "\$type = \"UNPUBLISHED\"" publications.bib
bib2bib -ob books.bib -c "not booktitle : \"Newsletter\" and \$type = \"INCOLLECTION\"" publications.bib
bib2bib -ob edited.bib -c "editor : \"$1\" and (\$type = \"PROCEEDINGS\" or \$type = \"BOOK\")" publications.bib
bib2bib -ob other.bib -c  "author : \"$1\" and not \$type = \"ARTICLE\" and (not \$type = \"INCOLLECTION\" or booktitle : \"Newsletter\") and not \$type = \"INPROCEEDINGS\" and not \$type = \"UNPUBLISHED\"" publications.bib
