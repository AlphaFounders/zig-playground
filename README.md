# zig webassembly experiment

brew install zig

zig build run

zig build test

zig build-lib math.zig -target wasm32-freestanding -dynamic

node test.js

npx serve -l 1234
