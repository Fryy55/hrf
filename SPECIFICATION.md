##### © 2026 Fryy_55. This specification is licensed under the **Creative Commons Attribution 4.0 International License (CC-BY-4.0)**.
###### Revision from 2026-07-06

<!-- omit from toc -->
# Heart Rate Format Specification


<!-- omit from toc -->
## Table of Contents
- [General Details](#general-details)
  - [Magic Number](#magic-number)
  - [File Extensions](#file-extensions)
- [Version 1](#version-1)
  - [Header](#header)
  - [Body](#body)
  - [File Validity](#file-validity)
  - [Size Estimations](#size-estimations)
  - [Standard Directory](#standard-directory)



# General Details
## Magic Number
The first 8 bytes of the file contain the magic number. Byte 0 specifies the version of the format, while bytes 1-7 are constant through all versions of the format (`48 52 46 06 07 54 52` hex, `H R F . . T R` ASCII with unprintable characters as `.`). Currently all possible magic numbers are (in hex):

- `01 48 52 46 06 07 54 52` - version 1


## File Extensions
| Version | Primary extension(s) |
| :-----: | -------------------- |
|    1    | `.hrf`               |



# Version 1
## Header
```
 [    MAGIC NUMBER    ]  [     TIMESTAMP      ]
 0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15
```

The file header consists of 16 bytes: 8 bytes for the magic number and 8 bytes for the UNIX timestamp of the time on which the session began in _little endian_


## Body
```
[0x56] [ Δt ] [0xff] [0x08] [0x01] [ Δt ] [0xb4] [ Δt ]
    16     17     18     19     20     21     22     23 ...
```

The body is a stream of heart rate values in the `[Δt], value` order

**Δt** is the number of milliseconds between the previous measurement and the current measurement integer-divided by 10 and clamped between `0x00` and `0xff`. Since Δt is an interval, the first heartbeat value in the body does _not_ have a Δt value before it and should be written at the same time as the header's timestamp

The heartbeat **value** depends on the value to write. If the heartbeat value is less than 255, the value written is a single byte as is. If it is 255 and higher the byte `0xff` is written, right after which a 2 byte value is written in _little endian_. This means 255 will be written as (in hex) `ff ff 00` and the largest value supported by the format (and by the heartrate GATT characteristic) is 65535 (`ff ff ff`; 2^16 - 1)


## File Validity
If a file has less than 17 bytes (empty body/non-full header) it is considered invalid

If the magic number does not match allowed magic numbers the file is considered invalid

If the last `Δt, value` pair in the body isn't fully written (only Δt is provided/less than 2 bytes are written after a `0xff` byte) this pair is discarded and the file is considered valid


## Size Estimations
<sub>With average for human HRMs values: broadcast frequency of ~1 Hz and an 8 bit value range</sub>

16 B (header) + 1 B + ~3600 * 2 B (body) ≈ 7217 B ≈ **7.048** KiB (per hour of recording)


## Standard Directory
Application reading this format can expect user's sessions to be stored at generic data directories in the `hrf-sessions/` subdirectory. That is:

- `C:\Users\username\AppData\Local\hrf-sessions` on Windows systems
- `/home/username/.local/share/hrf-sessions` on Linux systems
- `/Users/username/Library/Application Support/hrf-sessions` on macOS systems
- `/external/storage/root/Android/data/hrf-sessions` on Android systems
- `/app/home/Library/Application Support/hrf-sessions` on iOS systems

Applications that create sessions in the Heart Rate Format should write them to these directories directly