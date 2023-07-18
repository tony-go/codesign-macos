CMAKE=cmake
CODESIGN=codesign
CPACK=cpack

PRESET=Release

all: configure build package

configure:
	$(CMAKE) -G Xcode -B dist -DCMAKE_BUILD_TYPE=$(PRESET)

build: dist
	$(CMAKE) --build dist --config $(PRESET)

package: dist
	$(CPACK) -G DragNDrop -B dist --config ./dist/CPackConfig.cmake -C $(PRESET)

run: dist/Release/MyMacOSApp.app
	open ./dist/Release/MyMacOSApp.app

kill: dist/Release/MyMacOSApp.app
	killall MyMacOSApp

clean:
	rm -rf dist
