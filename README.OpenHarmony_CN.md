# move_to_background

本项目基于 [move_to_background](https://github.com/Sayegh7/move_to_background) 开发，为 OpenHarmony Flutter 场景提供将应用切换到后台的能力。

## 1. 安装与使用

### 1.1 安装方式

进入工程目录并在 `pubspec.yaml` 中添加依赖：

#### pubspec.yaml

```yaml
dependencies:
  move_to_background:
    git:
      url: https://gitcode.com/org/OpenHarmony-Flutter/move_to_background
      ref: master
```

执行命令：

```bash
flutter pub get
```

### 1.2 使用案例

使用案例详见 [example](example/lib/main.dart)。

最简单的调用方式：

```dart
import 'package:move_to_background/move_to_background.dart';

Future<void> handleBackAction() async {
  await MoveToBackground.moveTaskToBack();
}
```

## 2. 约束条件

1. Flutter: 3.7.2-ohos-1.1.1; SDK: 5.0.0(12); IDE: DevEco Studio: 5.1.0.828; ROM: 5.1.0.130 SP8;
2. Flutter: 3.22.0-ohos; SDK: 5.0.0(12); IDE: DevEco Studio: 5.1.0.828; ROM: 5.1.0.130 SP8;
3. Flutter: oh-3.27.4-dev; SDK: 5.0.0(12); IDE: DevEco Studio: 5.1.0.828; ROM: 5.1.0.130 SP8;
4. Flutter: oh-3.35.7-dev; SDK: 5.0.0(12); IDE: DevEco Studio: 5.1.0.828; ROM: 5.1.0.130 SP8;

## 3. 版本和框架对应关系

|       | 3.7 | 3.22 | 3.27 | 3.35 |
|-------|-----|------|------|------|
| 1.0.2 | yes | yes  | yes  | yes  |

## 4. API

> [!TIP] "ohos Support" 列：yes 表示支持；no 表示不支持；partially 表示部分支持。

| Name | Description | Type | Input | Output | ohos Support |
| --- | --- | --- | --- | --- | --- |
| moveTaskToBack | 将当前 Flutter 应用对应的 UIAbility 主窗口最小化到后台 | function | 无 | `Future<void>` | yes |

## 5. 遗留问题

## 6. 开源协议

本项目基于 [MIT](LICENSE) 开源。
