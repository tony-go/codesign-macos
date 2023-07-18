CMAKE=cmake
CODESIGN=codesign
CPACK=cpack

PRESET=Release

all: configure build package sign-dmg verify-app verify-dmg

configure:
	$(CMAKE) -G Xcode -B dist -DTEAM_ID=$(TEAM_ID) -DCMAKE_BUILD_TYPE=$(PRESET)

build: dist
	$(CMAKE) --build dist --config $(PRESET)

package: dist
	$(CPACK) -G DragNDrop -B dist --config ./dist/CPackConfig.cmake -C $(PRESET)

sign-dmg: dist
	$(CODESIGN) --force --verbose=2 --sign "$(TEAM_ID)" ./dist/MyMacOSApp-0.1.1-Darwin.dmg

verify-app: dist
	$(CODESIGN) --verify --verbose=2 ./dist/Release/MyMacOSApp.app

verify-dmg: dist
	$(CODESIGN) --verify --verbose=2 ./dist/MyMacOSApp-0.1.1-Darwin.dmg

run: dist/Release/MyMacOSApp.app
	open ./dist/Release/MyMacOSApp.app

kill: dist/Release/MyMacOSApp.app
	killall MyMacOSApp

clean:
	rm -rf dist
