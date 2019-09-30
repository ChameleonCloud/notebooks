#!/usr/bin/env bash

launch_base="https://jupyter.chameleoncloud.org/import?source=github&src_path=chameleoncloud/notebooks&file_path="

launch_badge() {
  local filepath="$(sed -e 's/^\.\///' -e 's/\//%2F/g' <<<"$1")"
  echo "[![Launch on Chameleon](https://img.shields.io/badge/launch-chameleon-brightgreen)]($launch_base$filepath)"
}

gen_section() {
  local section="$1"
  local out="\ \n"

  echo "Generating $section section..."
  for file in $(find . -type f -path "./$section/*" -name '*.ipynb' ! -name 'TutorialTemplate.ipynb'); do
    echo "  $file"
    name="$(basename $file)"
    out="$out- $(launch_badge $file) **[${name%.ipynb}]($file)**\n"
  done

  local lead="^<!-- BEGIN LAUNCHERS $section -->\$"
  local tail="^<!-- END LAUNCHERS $section -->\$"
  gsed -i.bak -e "/$lead/,/$tail/{ /$lead/{p; a $out
}; /$tail/p; d; }" README.md && rm README.md.bak
}

for section in $@; do gen_section $section; done
