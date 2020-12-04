# go-release-executables
Release executable binaries for Go projects on GitHub

Use GitHub actions to create a release action and use this repo to perform build and publish tasks.

If you want to provide own implementation of `build.sh`, the file should exist in the root directory of the repo.

Takes optional arguments in `env`:
* `BUILDOPTS` : Any build options needed
* `SUBDIR` : If repository contains separate projects in different subdirectories, mention path/to/subdir here
* `EXECUTABLE_NAME` : Name of the executable, else defaults to project name

Sample syntax for actions yml file:
```
on: release
name: Build Release
jobs:
  jobname1:
    name: utility-1
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: compile and release i386
      uses: ibm/go-release-executables@v1.0.0
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        GOARCH: "386"
        GOOS: linux
        SUBDIR: "subdir"
        EXECUTABLE_NAME: "exec1"
    - name: compile and release x86
      uses: ibm/go-release-executables@v1.0.0
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        GOARCH: amd64
        GOOS: linux
        SUBDIR: "subdir"
        EXECUTABLE_NAME: "exec2"
  jobname2:
    name: utility-2
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: compile and release x86
      uses: ibm/go-release-executables@v1.0.0
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        GOARCH: amd64
        GOOS: linux
        SUBDIR: "subdir"
        EXECUTABLE_NAME: "exec3"
```
