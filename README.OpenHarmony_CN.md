# move_to_background

本项目基于 [move_to_background](https://github.com/Sayegh7/move_to_background) 开发。

## 简介

move_to_background 是一个 Flutter 插件，提供将应用切换到后台的能力，仅需一行代码即可把当前 Flutter 应用切换到后台。本项目为 OpenHarmony 平台提供了该能力的适配实现。

## 下载安装

进入到工程目录并在 pubspec.yaml 中添加以下依赖：

```yaml
dependencies:
  move_to_background:
    git:
      url: https://gitcode.com/CPF-Flutter/fluttertpc_move_to_background.git
      ref: 1.0.2-ohos-1.0.0
```

执行命令：

```bash
flutter pub get
```

> TAG 命名规则：`原库版本-ohos-版本号`，不同 TAG 之间的变更详见 [CHANGELOG.OpenHarmony.md](CHANGELOG.OpenHarmony.md)。

| Flutter 框架版本 | TAG 名称 | 分支名 |
|---|---|---|
| 3.7 | 1.0.2-ohos-1.0.0 | master |
| 3.22 | 1.0.2-ohos-1.0.0 | master |
| 3.27 | 1.0.2-ohos-1.0.0 | master |
| 3.35 | 1.0.2-ohos-1.0.0 | master |

## 约束与限制

### 兼容性

在以下版本中已测试通过：

1. Flutter: 3.7.2-ohos-1.1.1; SDK: 5.0.0(12); IDE: DevEco Studio: 5.1.0.828; ROM: 5.1.0.130 SP8;
2. Flutter: 3.22.0-ohos; SDK: 5.0.0(12); IDE: DevEco Studio: 5.1.0.828; ROM: 5.1.0.130 SP8;
3. Flutter: oh-3.27.4-dev; SDK: 5.0.0(12); IDE: DevEco Studio: 5.1.0.828; ROM: 5.1.0.130 SP8;
4. Flutter: oh-3.35.7-dev; SDK: 5.0.0(12); IDE: DevEco Studio: 5.1.0.828; ROM: 5.1.0.130 SP8;

### 权限要求

无。

## 使用示例

以下示例展示 move_to_background 最简单的使用方式：点击按钮或将当前应用切换到后台。

```dart
import 'package:flutter/material.dart';
import 'package:move_to_background/move_to_background.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('MoveToBackground Example')),
        body: Center(
          child: ElevatedButton(
            // 点击按钮将当前应用切换到后台
            onPressed: () => MoveToBackground.moveTaskToBack(),
            child: const Text('切换到后台'),
          ),
        ),
      ),
    );
  }
}
```

## 使用说明

move_to_background 通过 `MoveToBackground.moveTaskToBack()` 方法将当前 Flutter 应用对应的 UIAbility 主窗口最小化到后台。在 OpenHarmony 平台上，该方法内部调用窗口的 `minimize` 能力实现后台切换效果。

最简调用：

```dart
import 'package:move_to_background/move_to_background.dart';

Future<void> handleBackAction() async {
  // 将当前应用切换到后台
  await MoveToBackground.moveTaskToBack();
}
```

> **注意事项**：
> - 该方法为异步方法，返回 `Future<void>`，调用时建议使用 `await` 等待执行完成。
> - 在 OpenHarmony 平台，插件需依附于已挂载的 UIAbility；若 UIAbility 未挂载，调用会返回 `no_ability` 错误。

结合返回拦截场景，可在 `WillPopScope`（或 `PopScope`）中调用，使物理返回键将应用切换到后台而非退出：

```dart
WillPopScope(
  onWillPop: () async {
    // 拦截返回事件，将应用切换到后台
    await MoveToBackground.moveTaskToBack();
    return false;
  },
  child: MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('MoveToBackground Example')),
      body: const Center(child: Text('按返回键切换到后台')),
    ),
  ),
);
```

## 接口说明

### API

> [!TIP] "OpenHarmony 平台支持"列：是表示支持；否表示不支持。使用方法跨平台一致，效果对标 iOS 或 Android 的效果。

| 名称 | 描述 | 类型 | 参数类型 | 返回值 | 必填 | OpenHarmony 平台支持 |
|---|---|---|---|---|---|---|
| moveTaskToBack | 将当前 Flutter 应用对应的 UIAbility 主窗口最小化到后台 | 方法 | 无 | `Future<void>` | 是 | 是 |

## 遗留问题

无。

## 目录结构

```text
|---- move_to_background
|     |---- android              # android 适配代码
|     |---- example              # 完整示例应用
|     |     |---- lib            # 示例代码
|     |     |---- ohos           # 鸿蒙工程
|     |---- ios                  # ios 适配代码
|     |---- lib                  # 核心代码实现
|     |     |---- move_to_background.dart  # 库的主入口文件
|     |---- ohos                 # 鸿蒙适配代码
|     |     |---- src/main/ets/com/sayegh/move_to_background/MoveToBackgroundPlugin.ets  # 鸿蒙平台原生实现
|     |---- test                 # 单元测试文件
|     |---- CHANGELOG.md                 # 更新日志
|     |---- CHANGELOG.OpenHarmony.md     # 鸿蒙版本更新日志
|     |---- README.OpenSource.md         # 开源说明
|     |---- README.OpenHarmony.md        # 英文说明文档
|     |---- README.OpenHarmony_CN.md     # 中文说明文档
|     |---- pubspec.yaml                 # 配置文件
```

## 贡献代码

使用过程中发现任何问题都可以提 [Issue](https://gitcode.com/org/OpenHarmony-Flutter/move_to_background/issues)，当然，也非常欢迎发 [PR](https://gitcode.com/org/OpenHarmony-Flutter/move_to_background/pulls) 共建。

## 开源协议

本项目基于 [MIT](https://github.com/Sayegh7/move_to_background/blob/master/LICENSE)，请自由地享受和参与开源。
