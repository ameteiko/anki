
ANKI_MEDIA =  ~/Library/ApplicationSupport/Anki2/ameteiko/collection.media
DIST = ./dist/index.css
DEST = ${ANKI_MEDIA}/_base.css
DUMP = ${DEST}_dump
FONT = ./assets/fonts/icomoon/_icomoon.ttf

ICOMOON_SRC = ~/Downloads/icomoon
ICOMOON_ZIP = ${ICOMOON_SRC}.zip


clean:
	@rm -rf ./dist/*.css

build:
	@sass -I . src/scss/index.scss > ${DIST}
	@echo "Built the resulting stylesheet"

dump:
	@cp ${DEST} ${DUMP} 2>/dev/null || :
	@echo "Dumped the previous version"

rollback:
	@cp ${DUMP} ${DEST}
	@echo "Rolled back the previous version"

deploy: build dump
	@cp ${DIST} ${DEST}
	@cp ${FONT} ${ANKI_MEDIA}
	@echo "Copied styles to the Anki media!"

# Incorporates the IcoMoon font into the project structure,
font: $(ICOMOON_ZIP)
	@rm -rf ${ICOMOON_SRC}
	@unzip -qq ${ICOMOON_ZIP} -d ${ICOMOON_SRC}

	@cp ${ICOMOON_SRC}/fonts/icomoon.ttf ${FONT}
	@cp ${ICOMOON_SRC}/style.css ./assets/fonts/icomoon/icomoon.css
	@sed -i '' '1,12d' assets/fonts/icomoon/icomoon.css
	@rm -rf ${ICOMOON_SRC}

	@echo "Updated fonts in the project"
