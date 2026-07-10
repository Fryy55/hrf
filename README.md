# Heart Rate Format
Specification + visualizer for the Heart Rate Format - a format for storing data recorded during heartrate measuring sessions

Notable projects that use HRF (feel free to reach out to get your project added):
- [HRM Widget](https://github.com/Fryy55/hrm-widget)

## Format Registration
Follow these instructions to register the Heart Rate Format on your system, giving `.hrf` files proper names, MIME types and icons

### Windows
[Click here](https://downgit.github.io/#/home?url=https://github.com/Fryy55/hrf/blob/main/registration/windows.reg) to download a `windows.reg.zip` file. Unzip it, double click the `windows.reg` file inside and accept changes to register the HRF

> [!TIP]
> To make the changes appear immediately make sure to restart the File Explorer (open a **Task Manager**, find **Explorer** there, _right click_ it and click **Restart**)

### Linux
Run the following command:
```bash
curl -fsSL https://raw.githubusercontent.com/Fryy55/hrf/refs/heads/main/registration/linux.sh | bash
```


# Specification
See [SPECIFICATION.md](./SPECIFICATION.md) for a full specification document


# Visualizer
WIP


# License
This project (code tools) is distributed under the **Apache-2.0 License**.

See `LICENSE-CODE` for permissions, conditions and limitations.

Specification provided is distributed under the **Creative Commons Attribution 4.0 International License (CC-BY-4.0)**.

See `LICENSE-SPEC` for permissions, conditions and limitations.