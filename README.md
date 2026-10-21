# ZCode 本地语音输入（一键安装）

给 **ZCode 3.16.2（Windows x64）** 加一个完全本地的语音转文字按钮。双击脚本，自动下载依赖、备份、打补丁并启动 ZCode。

![语音按钮](docs/voice-button.png)

## 一键安装

1. 下载本仓库（Code → Download ZIP，或 `git clone`）。
2. 双击 **`Install-ZCodeVoice.cmd`**。
3. 如果 ZCode 正在运行，脚本会提示并在 5 秒后自动关闭它（可先按 Ctrl+C 取消）。
4. 首次运行会下载 whisper.cpp 引擎（约 3.5 MB）和 small 模型（约 181 MB），下载后校验 SHA-256。之后会使用 `%LOCALAPPDATA%\ZCodeVoice\cache` 缓存。
5. 脚本会备份原始 `app.asar`、应用补丁、安装语音资源，并自动启动 ZCode。

装完直接点输入框右侧的麦克风即可。

## 用法

- 点麦克风开始录音，再点一下停止并转写；文字插入当前光标位置。
- 录音中按 `Esc` 取消。
- **右键麦克风**切换“中文 / 自动（中英）”，选择会记住。
- 完全离线推理；音频只写临时文件，转写后立即删除；静音不会编造文字。
- 安装日志：`%LOCALAPPDATA%\ZCodeVoice\logs\install.log`
- 运行日志：`%TEMP%\zcode-voice.log`

## 卸载

双击 **`Uninstall-ZCodeVoice.cmd`**。脚本会关闭 ZCode、从 `%LOCALAPPDATA%\ZCodeVoice\backup` 还原原版 `app.asar`，并删除 `resources\voice`。

原版 `app.asar` 备份始终保留，方便手动恢复。

## 支持范围

- 仅支持 **ZCode 3.16.2 / Windows x64**（实测 `3.16.2.8769`）。
- ZCode 官方自动更新会覆盖 `app.asar`。更新后重新双击安装脚本即可。
- 如果 ZCode 安装在 `Program Files` 等受保护目录，请以管理员身份运行 `.cmd`。
- 不要从 ZCode 内置终端里运行安装脚本（脚本会关闭 ZCode，连终端一起结束）；请从资源管理器双击。

## 命令行选项

`Install-ZCodeVoice.ps1` 支持：

| 参数 | 说明 |
| --- | --- |
| `-DryRun` | 只生成并校验补丁，不修改安装；配合 `-AsarPath` 使用 |
| `-AsarPath <file>` | 指定用于 DryRun 的 asar |
| `-PackageDir <dir>` | 离线安装，目录中放 `whisper-bin-x64.zip` 和 `ggml-small-q5_1.bin` |
| `-ModelPath <file>` | 单独指定本地模型 |
| `-WhisperZipPath <file>` | 单独指定本地 whisper 压缩包 |
| `-NoLaunch` | 安装完成后不启动 ZCode |
| `-ForceClose` | 跳过 5 秒倒计时，直接关闭 ZCode |
| `-UseSystemNode` | 强制使用 PATH 中的 `node`（默认优先用 ZCode 自带的 Node，无需安装 Node.js） |
| `-Uninstall` | 卸载/还原 |

示例：

```powershell
powershell -ExecutionPolicy Bypass -File .\Install-ZCodeVoice.ps1 -PackageDir D:\offline-voice
```

## 它改了什么

- 新增 `resources\voice\`：whisper.cpp v1.7.6（`whisper-cli.exe` + 5 个 DLL）、`ggml-small-q5_1.bin`、`voice-worker.mjs`、许可说明。
- 修改 `resources\app.asar`：
  - 新增 `out/main/voice-entry.js`（主进程 IPC、worker 调度、`webContents.insertText`）
  - 新增 `out/main/voice-ui.js`（输入框右侧按钮、录音、重采样为 16 kHz 单声道 16-bit WAV）
  - `out/preload/index.cjs` 末尾暴露 `window.zcodeVoice.transcribe`
  - `package.json` 的 `main` 指向 wrapper
- 原 `app.asar` 备份到 `%LOCALAPPDATA%\ZCodeVoice\backup\`。

## 已验证

在 Windows 10/11 x64、ZCode `3.16.2.8769` 上：

- 双击一键安装，从官方原版、空缓存开始，自动下载并校验引擎/模型，安装后 ZCode 正常启动。
- 输入框右侧按钮存在；`window.zcodeVoice` 可用。
- 转写中文 WAV 返回 33 字，`inserted: true`，文字进入 Lexical 草稿。
- 完整按钮路径（fake mic 录 4.6 秒）转写 19 字并插入。
- 静音返回 `no_speech`，不编造文字。
- 安装后的 `app.asar` SHA-256：`2d787641ad482f046996ed141230b6e87f548fb35b12665da24b7fe190014093`
- 官方 `3.16.2.8769` 原始 `app.asar` SHA-256：`1f960ba24a4a6687bb29090a9ac3273c06e9fc18b14882525f591132650a99a8`

## 许可与声明

- 本仓库脚本：MIT，见 [LICENSE](LICENSE)。
- whisper.cpp：MIT；Whisper 模型权重来自 OpenAI Whisper（MIT）。详见 [NOTICE.md](NOTICE.md)。
- 本项目是非官方修改，与 ZCode / Z.ai 无隶属关系；使用风险自负。
