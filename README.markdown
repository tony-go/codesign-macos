# Codesign macOS application with CMake

This project illustrates how we could codesign a macOS application with CMake.

In this project will try to codesign a basic CLI application written in C++.

## Requirements

- CMake
- Xcode

## Codesign the application

1. Create a build directory
   ```sh
   $ mkdir build
   ```

2. Change directory to `./build/`
   ```sh
   $ cd build
   ```

3. Generate Xcode project
   ```sh
   $ cmake .. -GXcode -DTEAM_ID=<YOUR TEAM-ID>
   ```

   For example if your certificate is: `Developer ID Application: JOHN, DOE (X4MF6H9XZ6)`.

   You will use in this way:
   ```sh
   $ cmake .. -GXcode -DTEAM_ID=X4MF6H9XZ6
   ```
   
   > Note: If you use an "Apple Developement" certificate, You'll have to go to the "Keychain Access"
   > and look at the "Get Info" menu, then you'll get the "Organisational Unit" that you'll use.
   ![Screenshot 2023-06-02 at 12 33 18](https://github.com/tony-go/codesign-macos/assets/22824417/6d16f344-281d-4e67-a910-42a9b739ce71)


4. Build the project
   ```sh
   $ cmake --build .
   ```

🎉 The cli app is codesigned!

> Note: The CLI binary is available at `./Debug/MyCLIApp`

## Check codesign

You can use two commands to check that the binary is properly codesigned.

> Note: you should be in the `./build/` folder.

### `codesign --verify`

```sh
$ codesign --verify --verbose=2 ./Debug/MyCLIApp
```

You should see something like:

```text
./Debug/MyCLIApp: valid on disk
./Debug/MyCLIApp: satisfies its Designated Requirement
```

### `codesign --display`

This command will show more information about the signature.

```sh
$ codesign --display --verbose=2 ./Debug/MyCLIApp
```

You should see something like:

```text
Authority=Developer ID Application: <YOUR NAME> (<TEAM-ID>)
```

