#!/usr/bin/env bash

binder_base="https://mybinder.org/v2/gh/ChameleonCloud/notebooks/master"

binder_badge() {
  local filepath="$(sed -e 's/^\.\///' -e 's/\//%2F/g' <<<"$1")"
  echo "[![Binder](https://mybinder.org/badge_logo.svg)]($binder_base?filepath=$filepath)"
}

gen_section() {
  local section="$1"
  local out="\ \n"

  echo "Generating $section section..."
  for file in $(find . -type f -path "./$section/*" -name '*.ipynb' ! -name 'TutorialTemplate.ipynb'); do
    echo "  $file"
    name="$(basename $file)"
    binder_link="meh"
    out="$out- $(binder_badge $file) **[${name%.ipynb}]($file)**\n"
  done

  local lead="^<!-- BEGIN BINDERS $section -->\$"
  local tail="^<!-- END BINDERS $section -->\$"
  gsed -i.bak -e "/$lead/,/$tail/{ /$lead/{p; a $out
}; /$tail/p; d; }" README.md && rm README.md.bak
}

for section in $@; do gen_section $section; done
