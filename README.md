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
- **智能压缩策略**：200-600KB 上传优化区间
- **自适应压缩**：根据目标大小自动调整压缩质量
- **异步支持**：后台线程压缩，避免阻塞 UI
- **长边约束**：确保压缩后图片长边不低于 256 像素
- **高质量首包**：长边 cap ≤ 4096，优先使用高质量压缩

## 架构设计

```
DeviceImpressSwift/
├── SystemService.swift          # 系统服务入口，整合所有设备信息
├── Device/
│   ├── DeviceService.swift       # 设备基础信息（IDFA、屏幕、电池等）
│   └── PhoneService.swift        # 设备型号识别
├── Storage/
│   └── StorageService.swift      # 内存和磁盘存储信息
├── Time/
│   └── TimeService.swift         # 系统时间相关（启动时间等）
├── Network/
│   └── NetworkService.swift      # 网络状态检测
├── Broken/
│   └── BrokenService.swift        # 越狱检测
└── Impress/
    └── ObjcImgPressAnTool.swift   # 图片压缩引擎
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
pod 'DeviceImpressSwift/Impress'
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

## 使用示例

### 获取完整设备信息

```swift
import DeviceImpressSwift

let deviceInfo = SystemService.getDeviceInfo(uuid: "your-uuid-here")
// 返回字典包含以下字段：
// uuid, screenResolution, screenWidth, screenHeight, cpuNum, ramTotal, ramCanUse
// batteryLevel, charged, totalBootTime, totalBootTimeWake, defaultLanguage, defaultTimeZone
// idfa, idfv, phoneMark, phoneType, systemVersions, versionCode, network
// wifiName, wifiBssid, isvpn, lastBootTime, proxied, simulated, debugged
// screenBrightness, cashTotal, cashCanUse, rooted
```

### 设备信息服务

```swift
// 获取设备型号
let deviceModel = PhoneService().deviceModelName()  // e.g., "iPhone 16 Pro"

// 获取屏幕分辨率
let resolution = DeviceService().screenResolution()  // e.g., "1179-2556"

// 获取电池电量
let batteryLevel = DeviceService().batteryLevel()   // e.g., "85"

// 获取 IDFA（需要用户授权）
let idfa = DeviceService().idfa()

// 获取 CPU 核心数
let cpuCount = DeviceService().cpuNum()
```

### 网络状态检测

```swift
let networkService = NetworkService()

// 获取网络类型详情
let networkType = networkService.networkTypeDetail()  // WiFi/4G/5G/etc

// 获取网络类型代码
let networkCode = networkService.networkTypeNumber()  // 0-5

// 检测 VPN
let isVPN = networkService.isVpn()                    // "true" or "false"

// 检测代理
let isProxied = networkService.proxied()              // "true" or "false"

// 获取 WiFi 信息
if let wifiInfo = networkService.wifiInfo() {
    let ssid = wifiInfo["ssid"]      // WiFi 名称
    let bssid = wifiInfo["bssid"]    // WiFi BSSID
}
```

### 存储信息

```swift
let storageService = StorageService()

// 获取总内存
let totalRAM = storageService.ramTotal()        // 单位：GB

// 获取可用内存
let availableRAM = storageService.ramCanUse()   // 单位：GB

// 获取总磁盘空间
let totalDisk = storageService.cashTotal()      // 单位：GB

// 获取可用磁盘空间
let availableDisk = storageService.cashCanUse() // 单位：GB
```

### 时间信息

```swift
let timeService = TimeService()

// 获取系统启动总时间（毫秒）
let bootTime = timeService.totalBootTime()

// 获取系统唤醒时间（毫秒）
let wakeTime = timeService.totalBootTimeWake()

// 获取上次启动时间戳（毫秒）
let lastBootTimestamp = timeService.lastBootTime()
```

### 越狱检测

```swift
let brokenService = BrokenService()

// 检测设备是否越狱
let isJailbroken = brokenService.brokenCrackStatus()  // "true" or "false"
// 返回值 ≥3 表示设备已越狱
```

### 图片压缩

**同步压缩**

```swift
import DeviceImpressSwift

// 压缩图片到 200-600KB
let result = ImpressService.compressForUpload200to600(image: image)

switch result {
case .success(let output):
    let jpegData = output.data      // 压缩后的 JPEG 数据
    let compressedImage = output.image  // 压缩后的 UIImage
    let base64String = output.base64   // Base64 编码字符串（首次访问时计算并缓存）
case .failure(let error):
    switch error {
    case .invalidKBRange(let minKB, let maxKB):
        print("无效的 KB 范围: \(minKB)-\(maxKB)")
    case .unableToEncode:
        print("无法编码图片")
    case .unableToReachTarget:
        print("无法达到目标压缩大小")
    }
}
```

**异步压缩**

```swift
ImpressService.compressForUploadKilobyteRange200to600Async(image: image) { result in
    DispatchQueue.main.async {
        switch result {
        case .success(let output):
            print("压缩成功，大小: \(output.data.count) bytes")
        case .failure(let error):
            print("压缩失败: \(error)")
        }
    }
}
```

**UIImage 扩展方法**

```swift
let result = image.ipan_compressForUploadKilobyteRange200to600()
if case .success(let output) = result {
    // 使用压缩结果
}
```

### 图片压缩策略说明

| 文件大小 | 处理策略 |
|----------|----------|
| < 200KB | 不检查长边，直接上传 |
| 200-600KB | 长边 ≥ 256 直接上传；长边 < 256 时在 ≤600KB 内拉伸至长边 ≥ 256 |
| > 600KB | 压缩至 200-600KB 区间 |

**参数说明**：
- **最大长边像素**：4096
- **最小长边像素**：256
- **目标大小范围**：200KB - 600KB

## 子模块说明

| 子模块 | 功能 | 框架依赖 |
|--------|------|----------|
| `DeviceImpressSwift/Device` | 设备信息采集（IDFA、屏幕、电池等） | UIKit, CoreTelephony, AppTrackingTransparency, AdSupport |
| `DeviceImpressSwift/Network` | 网络状态检测 | UIKit, CoreTelephony, AppTrackingTransparency |
| `DeviceImpressSwift/Storage` | 存储信息获取 | UIKit |
| `DeviceImpressSwift/Time` | 系统时间信息 | UIKit |
| `DeviceImpressSwift/Broken` | 越狱检测 | UIKit |
| `DeviceImpressSwift/Impress` | 图片压缩引擎 | UIKit |

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

### TimeService

| 方法 | 返回值 | 说明 |
|------|--------|------|
| `totalBootTime()` | `String` | 系统启动总时间（毫秒） |
| `totalBootTimeWake()` | `String` | 系统唤醒时间（毫秒） |
| `lastBootTime()` | `String` | 上次启动时间戳（毫秒） |

### BrokenService

| 方法 | 返回值 | 说明 |
|------|--------|------|
| `brokenCrackStatus()` | `String` | 越狱检测结果（返回值 ≥3 表示越狱） |

### ObjcImgPressAnTool

| 方法 | 返回值 | 说明 |
|------|--------|------|
| `compressForUpload200to600(image:)` | `Result<ImpressOutput, ImpressError>` | 压缩图片到 200-600KB |
| `compressForUpload200to600Optional(image:)` | `ImpressOutput?` | 可选版本压缩 |
| `compressForUploadKilobyteRange200to600Async(image:completion:)` | `Void` | 异步压缩 |
| `compressForUpload200to600Async(image:completion:)` | `Void` | Objective-C 兼容的异步压缩 |

### ImpressOutput

| 属性 | 类型 | 说明 |
|------|------|------|
| `data` | `Data` | 压缩后的 JPEG 数据 |
| `image` | `UIImage` | 压缩后的图片对象 |
| `base64` | `String` | Base64 编码字符串（懒加载，线程安全） |

### ImpressError

| 错误类型 | 说明 |
|----------|------|
| `invalidKBRange` | 无效的 KB 范围 |
| `unableToEncode` | 无法编码图片 |
| `unableToReachTarget` | 无法达到目标压缩大小 |

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
