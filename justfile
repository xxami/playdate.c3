
x86_64 := if arch() == "x86_64" {
    "OK"
} else {
    "FAILED (requires x86_64)"
}

playdate_sdk := if env("PLAYDATE_SDK_PATH") != "" {
    "OK"
} else {
    "FAILED (couldn't find playdate SDK)"
}

target := if os() == "windows" {
    "windows64"
} else {
    "linux64"
}
    
check:
    @echo "Performing checks..."
    @echo "Can build for simulator..." {{x86_64}}
    @echo "SDK installed..." {{playdate_sdk}}

build-sim:
    @echo "Performing build..."
    @echo "SDK: '{{env("PLAYDATE_SDK_PATH")}}'"
    c3 build playdate_{{target}}

build-device:
    @echo "Performing Build..."
    @echo "SDK: '{{env("PLAYDATE_SDK_PATH")}}'"
    c3 build playdate_device

    
