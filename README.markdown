# Codesign macOS application with CMake

This project illustrate how could we codesign a macOS application with CMake.

In this project will try to codesign a basic CLI application written in C++.

> Note: this tutotial works for "Developer ID Application" certificate.

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

   For example if you certificate is: `Developer ID Application: JOHN, DOE (X4MF6H9XZ6)`.

   You will use in this way:
   ```sh
   $ cmake .. -GXcode -DTEAM_ID=X4MF6H9XZ6
   ```

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

