# 星痕共鸣实时战斗数据统计工具 (Star Resonance Damage Counter)

[![License: AGPL v3](https://img.shields.io/badge/License-AGPL%20v3-brightgreen.svg)](https://www.gnu.org/licenses/agpl-3.0.txt)
[![Node.js](https://img.shields.io/badge/Node.js-22%2B-green.svg)](https://nodejs.org/)
[![npm](https://img.shields.io/badge/npm-included%20with%20Node.js-red.svg)](https://www.npmjs.com/)

一个用于《星痕共鸣》游戏的实时战斗数据统计工具，通过网络抓包技术实时分析战斗数据，提供伤害统计、DPS 计算等功能。

**🎉 Enhanced Version with Zero-Prerequisites Installation!**

该工具的数据准确性已经经过多次实际战斗验证，在网络环境稳定的情况下暂未发现数据丢失的问题。

该工具无需修改游戏客户端，不违反游戏服务条款。该工具旨在帮助玩家更好地理解战斗数据，减少无效提升，提升游戏体验。使用该工具前，请确保不会将数据结果用于战力歧视等破坏游戏社区环境的行为。

[介绍视频](https://www.bilibili.com/video/BV1T4hGzGEeX/)

## 🚀 Quick Start (Zero Prerequisites)

**For users with nothing installed:**

1. **Download** this project (extract ZIP file)
2. **Double-click:** `install-everything.bat`
3. **Follow prompts** (takes 5-10 minutes) 
4. **Launch:** `quick-start.bat`

That's it! Everything downloads and installs automatically.

## ✨ 功能特性

### 🎮 游戏体验优化
- 🎯 **实时伤害统计** - 实时捕获并统计战斗中的伤害数据
- 📊 **DPS 计算** - 提供瞬时 DPS 和总体 DPS 计算
- 🎲 **详细分类** - 区分普通伤害、暴击伤害、幸运伤害等类型
- 🌐 **Web 界面** - 提供美观的实时数据展示界面，折线图展示
- 🌙 **主题切换** - 支持日间/夜间模式切换
-  **统计分析** - 暴击率、幸运率等详细统计信息

### 🎯 增强版专属功能
- 🖥️ **游戏覆盖层** - 始终保持在游戏窗口顶层显示
- ⌨️ **快捷键支持** - F1-F12 快速切换数据视图和窗口模式
- 🌍 **多语言支持** - 支持中文/英文界面切换
- 🔄 **自动刷新** - 数据实时更新，无需手动刷新

## 🚀 快速开始

### ⚡ 零基础用户 (推荐)

如果你的电脑没有安装任何开发工具，使用以下一键安装：

1. **下载项目** - 点击绿色的 "Code" 按钮 → "Download ZIP" 并解压
2. **运行安装** - 双击 `install-everything.bat` 
3. **等待完成** - 程序会自动下载并安装所需软件 (5-10分钟)
4. **启动工具** - 双击 `quick-start.bat`

✅ **自动安装内容：** Node.js, npm 依赖包, Npcap 网络抓包驱动

### 📦 一键下载版本

前往 [GitHub Actions 页面](https://github.com/dmlgzs/StarResonanceDamageCounter/actions) 下载最新自动打包版本。

前往 [Release 页面](https://github.com/dmlgzs/StarResonanceDamageCounter/releases) 下载发布版本。

前往 [夸克网盘](https://pan.quark.cn/s/89c4795e0751) 下载发布版本。

### 🔧 开发者用户

如果你已有 Node.js 环境：

```bash
npm install
node server.js
```

### 🛠️ 手动编译

#### 前置要求

- **Node.js** >= 20.0.0
- **npm** (included with Node.js)
- **WinPcap/Npcap** (网络抓包驱动)

#### 安装步骤

1. **克隆仓库**

   ```bash
   git clone https://github.com/dmlgzs/StarResonanceDamageCounter.git
   cd StarResonanceDamageCounter
   ```

2. **安装依赖**

   ```bash
   npm install
   ```

3. **安装 WinPcap/Npcap**
   - 下载并安装 [Npcap](https://nmap.org/npcap/) 或 [WinPcap](https://www.winpcap.org/)（推荐 Npcap）
   - 确保安装时选择了“WinPcap API-compatible mode”

4. **运行**

   ```bash
   node server.js
   ```

   运行后将提示你：
   - 选择用于抓包的网络设备（可通过控制面板查看网卡信息）
   - 选择日志等级（`info`：基础信息，`debug`：详细日志）

   你也可以通过命令行参数直接指定：

   ```bash
   node server.js <device_number> <log_level>
   ```

   或使用自动检测模式（推荐）：

   ```bash
   node server.js auto info
   ```

   自动检测模式会：
   - 智能识别物理网卡，排除虚拟网卡（如 ZeroTier、VMware 等）
   - 分析 3 秒网络流量，自动选择最活跃的网卡
   - 无流量时回退到路由表方法

   手动指定示例：

   ```bash
   node server.js 4 info
   ```

### 使用方法

1. **选择网络设备**
   - 启动程序后，会显示可用的网络设备列表
   - 输入对应设备在程序输出的列表里显示的数字编号（通常选择主网卡）
   - 可以前往控制面板或者系统设置查找使用的网卡

2. **设置日志级别**
   - 选择日志级别：`info` 或 `debug`
   - 推荐使用 `info` 级别以减少日志输出

3. **启动游戏**
   - 程序会自动检测游戏服务器连接
   - 当检测到游戏服务器时，会输出服务器信息，并开始统计数据

4. **查看数据**
   - 打开浏览器访问：`http://localhost:8989`
   - 实时查看战斗数据统计

## 🎮 增强版使用指南

### 🚀 游戏覆盖层模式

使用零基础安装后，工具会启动一个始终保持在游戏顶层的覆盖窗口：

- **自动启动** - `quick-start.bat` 会同时启动服务器和覆盖层
- **游戏兼容** - 支持全屏游戏，覆盖层始终可见
- **透明界面** - 不影响游戏操作，数据清晰显示

### ⌨️ 快捷键操作

| 快捷键 | 功能描述 |
|--------|----------|
| **F1** | 切换数据视图（伤害/治疗/图表） |
| **F2** | 切换主题（日间/夜间模式） |
| **F3** | 切换语言（中文/English） |
| **F4** | 窗口透明度调节 |
| **F5** | 清空所有数据 |
| **F6** | 切换窗口大小（紧凑/标准） |
| **F12** | 显示/隐藏覆盖层 |

### 🔧 高级使用

**只需要网页版：**
```bash
node server.js
```

**启动游戏覆盖层：**
```bash
node overlay-launcher.js
```

## 📱 Web 界面功能

### 数据展示

- **角色 ID** - 玩家角色标识
- **总伤害/治疗** - 累计造成的总伤害/治疗量
- **伤害分类** - 纯暴击、纯幸运、暴击幸运等详细分类
- **暴击率/幸运率** - 战斗中的暴击和幸运触发概率
- **瞬时 DPS/HPS** - 当前秒的伤害/治疗输出
- **最大瞬时** - 历史最高瞬时输出记录
- **总 DPS/HPS** - 整体平均输出效率

### 操作功能

- **清空数据** - 重置所有统计数据
- **主题切换** - 在日间/夜间模式间切换
- **自动刷新** - 每 100ms 自动更新数据

## 🛠️ 技术架构

### 核心依赖

- **[cap](https://github.com/mscdex/cap)** - 网络数据包捕获
- **[express](https://expressjs.com/)** - Web 服务器框架
- **[protobufjs](https://github.com/protobufjs/protobuf.js)** - Protocol Buffers 解析
- **[winston](https://github.com/winstonjs/winston)** - 日志管理

## 📡 API 接口

### GET /api/data

获取实时战斗数据统计

**响应示例：**

```json
{
  "code": 0,
  "user": {
    "114514": {
      "realtime_dps": 0,
      "realtime_dps_max": 3342,
      "total_dps": 451.970764813365,
      "total_damage": {
        "normal": 9411,
        "critical": 246,
        "lucky": 732,
        "crit_lucky": 0,
        "hpLessen": 8956,
        "total": 10389
      },
      "total_count": {
        "normal": 76,
        "critical": 5,
        "lucky": 1,
        "total": 82
      },
      "realtime_hps": 4017,
      "realtime_hps_max": 11810,
      "total_hps": 4497.79970662755,
      "total_healing": {
        "normal": 115924,
        "critical": 18992,
        "lucky": 0,
        "crit_lucky": 0,
        "hpLessen": 0,
        "total": 134916
      },
      "taken_damage": 65,
      "profession": "愈合"
    }
  },
  "enemy": {
    "15395": {
      "name": "雷电食人魔",
      "hp": 18011262,
      "max_hp": 18011262
    }
  }
}
```

### GET /api/clear

清空所有统计数据

**响应示例：**

```json
{
  "code": 0,
  "msg": "Statistics have been cleared!"
}
```

### GET /api/enemies

获取敌方数据

**响应示例：**

```json
{
  "code": 0,
  "enemy": {
    "15395": {
      "name": "雷电食人魔",
      "hp": 18011262,
      "max_hp": 18011262
    }
  }
}
```

## 其余 API 可在[源码](server.js)中查看

## 🔧 故障排除

### 常见问题

1. **无法检测到游戏服务器**
   - 检查网络设备选择是否正确
   - 确认游戏正在运行且已连接服务器
   - 尝试前往同一张地图的非人群密集处

2. **Web 界面无法访问**
   - 检查端口 8989 是否被占用
   - 确认防火墙设置允许本地连接

3. **数据统计异常**
   - 检查日志输出是否有错误信息
   - 尝试重启程序重新捕获

4. **cap 模块编译错误**
   - 确保已安装 Visual Studio Build Tools 和 Python
   - 确认 Node.js 版本符合要求

5. **启动程序立马自动退出**
   - 确保已安装 Npcap
   - 确认网络设备选择输入了正确的数字编号

## 📄 许可证

[![](https://www.gnu.org/graphics/agplv3-with-text-162x68.png)](LICENSE)

本项目采用 [GNU AFFERO GENERAL PUBLIC LICENSE version 3](LICENSE) 许可证。

使用本项目即表示您同意遵守该许可证的条款。

### 衍生软件相关

- 若修改源代码并重新发布，必须在显著位置注明本项目。
- 若参考内部实现（如服务器识别、协议解析、数据处理等）发布另一个项目，必须在显著位置注明本项目。

如果您不认可本许可和附加条款，请不要使用本项目或查阅相关代码。

## 👥 贡献

欢迎提交 Issue 和 Pull Request 来改进项目！

### 贡献者名单

[![Contributors](https://contrib.rocks/image?repo=dmlgzs/StarResonanceDamageCounter)](https://github.com/dmlgzs/StarResonanceDamageCounter/graphs/contributors "Contributors")

## ⭐ 支持

如果这个项目对您有帮助，请给它一个 Star ⭐

---

**免责声明**：本工具仅用于游戏数据分析学习目的，不得用于任何违反游戏服务条款的行为。使用者需自行承担相关风险。项目开发者不对任何他人使用本工具的恶意战力歧视行为负责。请在使用前确保遵守游戏社区的相关规定和道德标准。
