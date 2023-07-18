# Codesign macOS application with CMake

This project illustrates how we could codesign a macOS application with CMake.

In this project will try to codesign a basic CLI application written in Objective-C.

## Requirements

- CMake
- Xcode

We'll use a `Makefile` for convenience.

## Codesign the application

Build, codesign and run your application:

```sh
TEAM_ID=<YOUR TEAM-ID> make
```

For example if your certificate is: `Developer ID Application: JOHN, DOE (X4MF6H9XZ6)`.

You will use in this way:
```sh
TEAM_ID=X4MF6H9XZ6 make
```

> Note: If you use an "Apple Development" certificate, You'll have to go to the "Keychain Access"
> and look at the "Get Info" menu, then you'll get the "Organisational Unit" that you'll use.
![Screenshot 2023-06-02 at 12 33 18](https://github.com/tony-go/codesign-macos/assets/22824417/6d16f344-281d-4e67-a910-42a9b739ce71)

🎉 The cli app is codesigned! The codesign part is done by CMake,
but if you are curious, you can see the command in the logs:

```text
CodeSign .../codesign-macos/dist/Debug/MyMacOSApp (in target 'MyCLIApp' from project 'MyCLIApp')
    cd .../codesign-macos

    Signing Identity:     <YOUR CERTIFICATE>

   <THE COMMAND>
```

> Note: The CLI binary is available at `./dist/Debug/MyMacOSApp`

### Codesign the disk image

```shell
codesign --force --verbose=2 --sign $TEAM_ID./dist/MyMacOSApp-0.1.1-Darwin.dmg
```

## Check codesign

The codesign verification is already done while running `make`, but 
you can use the following commands to check that the binary is properly codesigned.

### `codesign --verify`

#### for the `.app`

```sh
$ codesign --verify --verbose=2 ./dist/Debug/MyMacOSApp
```

> Note: that is the one I used in the Makefile

You should see something like:

```text
./dist/Debug/MyMacOSApp: valid on disk
./dist/Debug/MyMacOSApp: satisfies its Designated Requirement
```

#### for the `.dmg`

Same as `.app` but with the `.dmg` path.

```sh
$ codesign --verify --verbose=2 ./dist/Debug/MyMacOSApp-0.1.1-Darwin.dmg
```

### `codesign --display`

This command will show more information about the signature.

```sh
$ codesign --display --verbose=2 ./dist/Debug/MyMacOSApp
```

You should check in the console and see something like:

```text
Authority=Developer ID Application: <YOUR NAME> (<TEAM-ID>)
```

