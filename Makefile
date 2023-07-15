CMAKE=cmake
CODESIGN=codesign

all: configure build verify run

configure:
	$(CMAKE) -G Xcode -B dist -DTEAM_ID=$(TEAM_ID)

build: dist
	$(CMAKE) --build dist

verify: dist
	$(CODESIGN) --verify --verbose=2 ./dist/Debug/MyCLIApp

run: dist
	./dist/Debug/MyCLIApp

clean:
	rm -rf dist
