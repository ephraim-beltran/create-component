#!/bin/env bash

main() {
  local COMPONENT_NAME="$1"
  local CWD=$(pwd)
  local COMPONENT_DIR="$CWD/components/$COMPONENT_NAME"
  local INDEXFILE="$COMPONENT_DIR/index.js"
  local COMPONENT_FILE="$COMPONENT_DIR/$COMPONENT_NAME.jsx"

  if [[ ! -d "$CWD/components" ]]; then
    echo "Components directory not found"
    exit 1
  fi

  mkdir "$COMPONENT_DIR"

  if createIndex; then echo "Barrel file created"; fi
  if createComponentFile; then echo "Component file created"; fi

}

createIndex() {
  if ! touch "$INDEXFILE"; then return 1; fi
  echo "export * from './$COMPONENT_NAME';" &>/dev/null >>$INDEXFILE
  echo "export { default } from './$COMPONENT_NAME';" &>/dev/null >>$INDEXFILE
  return 0
}

createComponentFile() {
  if ! touch "$COMPONENT_FILE"; then return 1; fi
  echo "function $COMPONENT_NAME() {" &>/dev/null >>$COMPONENT_FILE
  echo -e "return (\n<p>This is a component</p>\n);" &>/dev/null >>$COMPONENT_FILE
  echo "}" &>/dev/null >>$COMPONENT_FILE
  echo -e "\nexport default $COMPONENT_NAME;" &>/dev/null >>$COMPONENT_FILE
  return 0
}

main "$@"
