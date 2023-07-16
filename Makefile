CMAKE=cmake
CODESIGN=codesign
CPACK=cpack

all: configure build package verify notarize run

configure:
	$(CMAKE) -G Xcode -B dist -DTEAM_ID=$(TEAM_ID)

build: dist
	$(CMAKE) --build dist

package: dist
	$(CPACK) -G DragNDrop -B dist --config ./dist/CPackConfig.cmake -C Debug

verify: dist
	$(CODESIGN) --verify --verbose=2 ./dist/Debug/MyCLIApp

notarize: dist
	xcrun notarytool submit ./dist/MyCLIApp-0.1.1-Darwin.dmg \
		--keychain-profile "$(KEYCHAIN_PROFILE)" \
		--wait

verify-notarize: dist
	xcrun spctl -a -t executable -vv ./dist/Debug/MyCLIApp

run: dist
	./dist/Debug/MyCLIApp

clean:
	rm -rf dist
