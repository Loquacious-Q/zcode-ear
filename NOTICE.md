# Third-party notices

This project bundles or downloads the following third-party components.

## whisper.cpp

- Version: v1.7.6 (Windows x64 prebuilt)
- License: MIT
- Source: https://github.com/ggml-org/whisper.cpp
- Release asset: https://github.com/ggml-org/whisper.cpp/releases/download/v1.7.6/whisper-bin-x64.zip
- SHA-256 of the release zip: `0d2eca299c248f965bd0341bcb219db4b433c7f0c0ce2200d4df85765e8156a9`

Bundled binaries: `whisper-cli.exe`, `whisper.dll`, `ggml.dll`, `ggml-base.dll`, `ggml-cpu.dll`.

## Whisper model

- File: `ggml-small-q5_1.bin`
- Source: https://huggingface.co/ggerganov/whisper.cpp
- Mirrors: https://hf-mirror.com/ggerganov/whisper.cpp
- OpenAI Whisper weights: MIT
- SHA-256: `ae85e4a935d7a567bd102fe55afc16bb595bdb618e11b2fc7591bc08120411bb`

The model is converted/quantized to ggml by the whisper.cpp project.

## ZCode

This project is an unofficial modification of the ZCode desktop app. It is not
affiliated with, endorsed by, or sponsored by ZCode or Z.ai. ZCode itself is
not distributed by this repository; users must install it separately.
