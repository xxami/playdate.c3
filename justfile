
project_name := "hello_world"
playdate_sdk := env("PLAYDATE_SDK_PATH")

target := os()
pdc_bin := if target == "windows" { "pdc.exe" } else { "pdc" }
bin_ext := if target == "windows" { "dll" } else { "so" }
    
default:
    @just --list

build-sim:
    @echo "Building for simulator..."
    @echo "SDK: '{{playdate_sdk}}'"
    c3 build playdate_{{target}}64
    mkdir -p build/cart res
    cp -r res/* build/cart/
    cp src/pdxinfo build/cart/pdxinfo
    cp build/playdate_{{target}}64.{{bin_ext}} build/cart/pdex.dll
    '{{join(playdate_sdk, "bin", pdc_bin)}}' -sdkpath '{{playdate_sdk}}' ./build/cart ./build/{{project_name}}.pdx

build-device:
    @echo "Building for device..."
    @echo "SDK: '{{playdate_sdk}}'"
    c3 build playdate_device
    mkdir -p build/cart res
    cp -r res/* build/cart/
    cp src/pdxinfo build/cart/pdxinfo

