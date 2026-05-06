# DeviceImpressSwift

[![iOS Deployment Target](https://img.shields.io/badge/iOS-14.0%2B-blue.svg)](https://cocoapods.org/pods/DeviceImpressSwift)
[![Swift Version](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![License](https://img.shields.io/cocoapods/l/DeviceImpressSwift.svg?style=flat)](https://cocoapods.org/pods/DeviceImpressSwift)

DeviceImpressSwift 是一个功能全面的 iOS 设备信息采集和图片压缩工具库，支持设备识别、网络状态检测、存储监控、越狱检测以及智能图片压缩。

## 功能特性

### 设备信息采集
- **设备型号识别**：支持从 iPhone 5 到 iPhone 17 全系列设备型号识别
- **屏幕信息**：分辨率、亮度、像素密度
- **系统信息**：CPU 核心数、内存状态、存储空间
- **电池状态**：电量、充电状态
- **标识符**：IDFA、IDFV、UUID
- **系统环境**：语言、时区、系统版本

### 网络状态检测
- **网络类型**：WiFi、2G、3G、4G、5G 自动识别
- **WiFi 信息**：SSID、BSSID 获取
- **安全检测**：VPN 连接检测、代理服务器检测

### 越狱检测
- Cydia 检测
- 越狱相关文件检测
- 符号链接检测
- 应用完整性检测

### 图片压缩
- **智能压缩策略**：200-600KB 上传优化
- **自适应压缩**：根据目标大小自动调整压缩质量
- **异步支持**：后台线程压缩，避免阻塞 UI
- **长边约束**：确保压缩后图片长边不低于 256 像素

## 架构设计

```
DeviceImpressSwift/
├── SystemService.swift      # 系统服务入口，整合所有设备信息
├── Device/
│   ├── DeviceService.swift    # 设备基础信息（IDFA、屏幕、电池等）
│   └── PhoneService.swift     # 设备型号识别
├── Storage/
│   └── StorageService.swift   # 内存和磁盘存储信息
├── Time/
│   └── TimeService.swift      # 系统时间相关（启动时间等）
├── Network/
│   └── NetworkService.swift   # 网络状态检测
├── Broken/
│   └── BrokenService.swift     # 越狱检测
└── Impress/
    └── ObjcImgPressAnTool.swift # 图片压缩引擎
```

## 快速开始

### 安装

**CocoaPods**

```ruby
# 安装完整功能（默认依赖所有子模块）
pod 'DeviceImpressSwift'

# 或只安装特定模块
pod 'DeviceImpressSwift/Network'
pod 'DeviceImpressSwift/Broken'
pod 'DeviceImpressSwift/Storage'
pod 'DeviceImpressSwift/Time'
pod 'DeviceImpressSwift/Device'
```

**手动集成**

将 `DeviceImpressSwift/Classes/` 目录下的所有文件添加到你的项目中。

### 框架依赖

本库需要以下系统框架支持：

| 框架 | 用途 |
|------|------|
| **UIKit** | 基础 UI 框架 |
| **CoreTelephony** | 网络状态检测 |
| **AppTrackingTransparency** | IDFA 获取（iOS 14+） |
| **AdSupport** | IDFA 获取 |

### 基本使用

**获取完整设备信息**

```swift
import DeviceImpressSwift

let deviceInfo = SystemService.getDeviceInfo(uuid: "your-uuid-here")
// 返回包含所有设备信息的字典
```

**单独使用各项服务**

```swift
// 获取设备型号
let deviceModel = PhoneService().deviceModelName()  // e.g., "iPhone 16 Pro"

// 获取屏幕分辨率
let resolution = DeviceService().screenResolution()  // e.g., "1179-2556"

// 获取电池状态
let batteryLevel = DeviceService().batteryLevel()   // e.g., "85"

// 检测越狱状态
let isJailbroken = BrokenService().brokenCrackStatus()  // "true" or "false"

// 图片压缩
let result = image.ipan_compressForUploadKilobyteRange200to600()
if case .success(let output) = result {
    let jpegData = output.data
    let base64String = output.base64
}
```

## 子模块说明

| 子模块 | 功能 | 框架依赖 |
|--------|------|----------|
| `DeviceImpressSwift/Device` | 设备信息采集（IDFA、屏幕、电池等） | UIKit, CoreTelephony, AppTrackingTransparency, AdSupport |
| `DeviceImpressSwift/Network` | 网络状态检测 | UIKit, CoreTelephony, AppTrackingTransparency |
| `DeviceImpressSwift/Storage` | 存储信息获取 | UIKit |
| `DeviceImpressSwift/Time` | 系统时间信息 | UIKit |
| `DeviceImpressSwift/Broken` | 越狱检测 | UIKit |

## API 文档

### SystemService

| 方法 | 返回值 | 说明 |
|------|--------|------|
| `getDeviceInfo(uuid:)` | `[String: Any]` | 获取完整设备信息字典 |

### DeviceService

| 方法 | 返回值 | 说明 |
|------|--------|------|
| `idfa()` | `String` | 获取 IDFA（需要用户授权，iOS 14+） |
| `screenResolution()` | `String` | 获取屏幕分辨率（格式：宽-高） |
| `screenBrightness()` | `String` | 获取屏幕亮度（0-100） |
| `cpuNum()` | `String` | 获取 CPU 核心数 |
| `batteryLevel()` | `String` | 获取电池电量（0-100，-1 表示未知） |
| `charged()` | `String` | 是否在充电（"true"/"false"） |
| `defaultLanguage()` | `String` | 获取系统默认语言代码 |
| `debugStatus()` | `String` | 是否处于调试模式 |

### PhoneService

| 方法 | 返回值 | 说明 |
|------|--------|------|
| `deviceModelName()` | `String` | 获取设备型号名称 |
| `deviceTypeNumber()` | `String` | 获取设备类型代码（iPhone=3, iPad=2, Mac=1） |
| `deviceUAType()` | `String` | 获取 UA 类型（Mobile/Tablet/pc） |

### StorageService

| 方法 | 返回值 | 说明 |
|------|--------|------|
| `ramTotal()` | `String` | 获取总内存（GB） |
| `ramCanUse()` | `String` | 获取可用内存（GB） |
| `cashTotal()` | `String` | 获取总磁盘空间（GB） |
| `cashCanUse()` | `String` | 获取可用磁盘空间（GB） |

### NetworkService

| 方法 | 返回值 | 说明 |
|------|--------|------|
| `networkTypeNumber()` | `String` | 网络类型代码（0=Unknown, 1=WiFi, 2=2G, 3=3G, 4=4G, 5=5G） |
| `networkTypeDetail()` | `String` | 网络类型详情（WiFi/4G/5G 等） |
| `isVpn()` | `String` | 是否使用 VPN |
| `proxied()` | `String` | 是否使用代理 |
| `wifiInfo()` | `[String: String]?` | WiFi 信息（ssid/bssid） |

### BrokenService

| 方法 | 返回值 | 说明 |
|------|--------|------|
| `brokenCrackStatus()` | `String` | 越狱检测结果（返回值 ≥3 表示越狱） |

### ObjcImgPressAnTool

| 方法 | 返回值 | 说明 |
|------|--------|------|
| `compressForUpload200to600(image:)` | `Result<ImgPressAnOutput, ImgPressAnError>` | 压缩图片到 200-600KB |
| `compressForUpload200to600Optional(image:)` | `ImgPressAnOutput?` | 可选版本压缩 |
| `compressForUploadKilobyteRange200to600Async(image:completion:)` | `Void` | 异步压缩 |

## 环境要求

- **iOS 14.0** 或更高版本
- **Swift 5.0** 或更高版本

## 示例项目

运行示例项目：

```bash
cd Example
pod install
open DeviceImpressSwift.xcworkspace
```

## 许可证

本项目基于 MIT 许可证开源，详见 [LICENSE](LICENSE) 文件。

## 作者

**yanwenbo78201**

- 邮箱：yanwenbo_78201@163.com
- GitHub：[https://github.com/yanwenbo78201/DeviceImpressSwift](https://github.com/yanwenbo78201/DeviceImpressSwift)

## 更新日志

### 0.1.0
- 初始版本发布
- 支持设备信息采集、网络检测、越狱检测、图片压缩
- 支持 CocoaPods 子模块按需集成
