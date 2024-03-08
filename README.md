![Logo](https://github.com/libobjc/SGPlayer/blob/master/documents/banner.jpg?raw=true)


![Build Status](https://img.shields.io/badge/build-%20passing%20-brightgreen)  ![License](https://img.shields.io/badge/license-MIT-red) ![Platform](https://img.shields.io/badge/Platform-%20iOS%20macOS%20tvOS%20-blue)

# SGPlayer 

- SGPlayer is a powerful media play framework for iOS
- 

## Features

- 360° panorama video.
- Compose complex asset.
- Background playback.
- RTMP/RTSP streaming.
- Setting playback speed.
- Multiple audio/video tracks.
- H.264/H.265 hardware accelerator.
- Accurate status notifications.
- Thread safety.

## Based On

- FFmpeg
- Metal
- AudioToolbox

## Requirements

- iOS 12.0 or later

## Getting Started

#### Build FFmpeg and OpenSSL 

- Build scripts are used by default for FFmpeg 6.1.1 and OpenSSL 1.1.1w

```obj-c
git clone https://github.com/XiaoLongTX/SGPlayerNewer.git
cd SGPlayer
./build.sh build

#### Open demo project in Xcode

- Open demo/demo.xcworkspace. You can see simple use cases.

#### Check Dependencies

```obj-c
- SGPlayer.framework
- AVFoundation.framework
- AudioToolBox.framework
- VideoToolBox.framework
- libiconv.tbd
- libbz2.tbd
- libz.tbd
```
