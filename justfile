
project_name := "hello_world"
playdate_sdk := env("PLAYDATE_SDK_PATH")
pdc_bin := if os() == "windows" { "pdc.exe" } else { "pdc" }
target := if os() == "windows" { "windows64" } else { "linux64" }
    
default:
    @just --list

build-sim:
    @echo "Building for simulator..."
    @echo "SDK: '{{playdate_sdk}}'"
    c3 build playdate_{{target}}
    cp ./pdxinfo build/cart/pdxinfo
    cp build/playdate_windows64.dll build/cart/pdex.dll
    '{{join(playdate_sdk, "bin", pdc_bin)}}' -sdkpath '{{playdate_sdk}}' ./build/cart ./build/{{project_name}}.pdx

build-device:
    @echo "Building for device..."
    @echo "SDK: '{{playdate_sdk}}'"
    c3 build playdate_device
