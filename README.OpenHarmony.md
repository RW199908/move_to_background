# move_to_background

This project is developed based on [move_to_background](https://github.com/Sayegh7/move_to_background) and provides the ability to move a Flutter application to the background on OpenHarmony.

## 1. Installation and Usage

### 1.1 Installation

Go to your project directory and add the dependency in `pubspec.yaml`:

#### pubspec.yaml

```yaml
dependencies:
  move_to_background:
    git:
      url: https://gitcode.com/org/OpenHarmony-Flutter/move_to_background
      ref: master
```

Run:

```bash
flutter pub get
```

### 1.2 Example

See [example](example/lib/main.dart) for a complete example.

The simplest usage is:

```dart
import 'package:move_to_background/move_to_background.dart';

Future<void> handleBackAction() async {
  await MoveToBackground.moveTaskToBack();
}
```

## 2. Constraints

1. Flutter: 3.7.2-ohos-1.1.1; SDK: 5.0.0(12); IDE: DevEco Studio: 5.1.0.828; ROM: 5.1.0.130 SP8;
2. Flutter: 3.22.0-ohos; SDK: 5.0.0(12); IDE: DevEco Studio: 5.1.0.828; ROM: 5.1.0.130 SP8;
3. Flutter: oh-3.27.4-dev; SDK: 5.0.0(12); IDE: DevEco Studio: 5.1.0.828; ROM: 5.1.0.130 SP8;
4. Flutter: oh-3.35.7-dev; SDK: 5.0.0(12); IDE: DevEco Studio: 5.1.0.828; ROM: 5.1.0.130 SP8;

## 3. Version and Framework Mapping

|       | 3.7 | 3.22 | 3.27 | 3.35 |
|-------|-----|------|------|------|
| 1.0.2 | yes | yes  | yes  | yes  |

## 4. API

> [!TIP] In the "ohos Support" column, yes means supported, no means unsupported, and partially means partially supported.

| Name | Description | Type | Input | Output | ohos Support |
| --- | --- | --- | --- | --- | --- |
| moveTaskToBack | Minimizes the main window of the current Flutter application's UIAbility to the background | function | None | `Future<void>` | yes |

## 5. Known Issues

## 6. Open Source License

This project is licensed under [MIT](LICENSE).
