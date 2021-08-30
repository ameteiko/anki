
DIST = ./dist/index.css
DEST = ~/Library/ApplicationSupport/Anki2/ameteiko/collection.media/_base.css
DUMP = ${DEST}_dump

clean:
	@rm -rf ./dist/*

build:
	@sass src/scss/index.scss > ${DIST}
	@echo "Built the resulting stylesheet"

dump:
	@cp ${DEST} ${DUMP} 2>/dev/null || :
	@echo "Dumped the previous version"

rollback:
	@cp ${DUMP} ${DEST}
	@echo "Rolled back the previous version"

deploy: build dump
	@cp ${DIST} ${DEST}
	@echo "Copied styles to the Anki media!"
