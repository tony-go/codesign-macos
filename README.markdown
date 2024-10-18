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
TEAM_ID=<YOUR TEAM-ID> make codesign-only
```

For example, if your certificate is: `Developer ID Application: JOHN, DOE (X4MF6H9XZ6)`.

You will use it this way:
```sh
TEAM_ID=X4MF6H9XZ6 make codesign-only
```

> Note: If you use an "Apple Development" certificate, you'll have to go to the "Keychain Access" app
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

### Check codesign

The codesign verification is already done while running `make`, but 
you can use the following commands to check that the binary is properly codesigned.

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

#### `codesign --display` (optional)

This command will show more information about the signature.

```sh
$ codesign --display --verbose=2 ./dist/Debug/MyMacOSApp
```

You should check in the console and see something like:

```text
Authority=Developer ID Application: <YOUR NAME> (<TEAM-ID>)
```

## Notarize application

> If you want to do the whole tutorial, please be sure that you are member of the 
Apple developer program that will allow you to generate a Developer ID.

### Create a keychain profile (store-credential)

```shell
xcrun notarytool store-credentials "KC_PROFILE" \
  --apple-id <APPLE_ID> \ 
  --team-id X4MF6H9XZ6  \
  --password <APP_SPECIFIC_PASSWORD>
```

Aiming to perform this store-credential command, you need three pieces of information:
- your Apple identifier, probably the email you use for login
- the team ID, for example if your certificate is: `Developer ID Application: JOHN, DOE (X4MF6H9XZ6)`
the team ID is: `X4MF6H9XZ6`
- an app-specific password: https://support.apple.com/en-us/HT204397

```shell
TEAM_ID=X4MF6H9XZ6 KEYCHAIN_PROFILE="KC_PROFILE" make
```

This command will perform:

- build
- codesign
- codesign verification
- notarization
- stapling
- notarization verification

If you want to dig more, look at the `Makefile`.
