# move_to_background

This project is developed based on [move_to_background](https://github.com/Sayegh7/move_to_background).

## Introduction

move_to_background is a Flutter plugin that provides the ability to move an application to the background, allowing you to move the current Flutter app to the background with a single line of code. This project provides the adaptation implementation of this capability for the OpenHarmony platform.

## Installation

Go to your project directory and add the following dependency in pubspec.yaml:

```yaml
dependencies:
  move_to_background:
    git:
      url: https://gitcode.com/CPF-Flutter/fluttertpc_move_to_background.git
      ref: 1.0.2-ohos-1.0.0
```

Run the command:

```bash
flutter pub get
```

> TAG naming rule: `original-version-ohos-version`. For changes between TAGs, see [CHANGELOG.OpenHarmony.md](CHANGELOG.OpenHarmony.md).

| Flutter framework version | TAG name | Branch |
|---|---|---|
| 3.7 | 1.0.2-ohos-1.0.0 | master |
| 3.22 | 1.0.2-ohos-1.0.0 | master |
| 3.27 | 1.0.2-ohos-1.0.0 | master |
| 3.35 | 1.0.2-ohos-1.0.0 | master |

## Constraints and Limitations

### Compatibility

Tested and passed on the following versions:

1. Flutter: 3.7.2-ohos-1.1.1; SDK: 5.0.0(12); IDE: DevEco Studio: 5.1.0.828; ROM: 5.1.0.130 SP8;
2. Flutter: 3.22.0-ohos; SDK: 5.0.0(12); IDE: DevEco Studio: 5.1.0.828; ROM: 5.1.0.130 SP8;
3. Flutter: oh-3.27.4-dev; SDK: 5.0.0(12); IDE: DevEco Studio: 5.1.0.828; ROM: 5.1.0.130 SP8;
4. Flutter: oh-3.35.7-dev; SDK: 5.0.0(12); IDE: DevEco Studio: 5.1.0.828; ROM: 5.1.0.130 SP8;

### Permission Requirements

None.

## Usage Example

The following example shows the simplest usage of move_to_background: tapping a button to move the current app to the background.

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
            // Tap the button to move the current app to the background
            onPressed: () => MoveToBackground.moveTaskToBack(),
            child: const Text('Move to background'),
          ),
        ),
      ),
    );
  }
}
```

## Usage Instructions

move_to_background moves the main window of the UIAbility corresponding to the current Flutter app to the background via the `MoveToBackground.moveTaskToBack()` method. On the OpenHarmony platform, this method internally calls the `minimize` capability of the window to move the app to the background.

Minimal invocation:

```dart
import 'package:move_to_background/move_to_background.dart';

Future<void> handleBackAction() async {
  // Move the current app to the background
  await MoveToBackground.moveTaskToBack();
}
```

> **Notes**:
> - This method is asynchronous and returns `Future<void>`. It is recommended to use `await` to wait for it to complete.
> - On the OpenHarmony platform, the plugin relies on an attached UIAbility. If no UIAbility is attached, the call returns a `no_ability` error.

Combined with a back-press scenario, you can call it inside `WillPopScope` (or `PopScope`) so that the physical back button moves the app to the background instead of exiting:

```dart
WillPopScope(
  onWillPop: () async {
    // Intercept the back event and move the app to the background
    await MoveToBackground.moveTaskToBack();
    return false;
  },
  child: MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('MoveToBackground Example')),
      body: const Center(child: Text('Press back to move to background')),
    ),
  ),
);
```

## Interface Description

### API

> [!TIP] In the "OpenHarmony Support" column, Yes means supported and No means not supported. The usage is consistent across platforms, with the effect benchmarked against iOS or Android.

| Name | Description | Type | Parameter Type | Return Value | Required | OpenHarmony Support |
|---|---|---|---|---|---|---|
| moveTaskToBack | Minimizes the main window of the UIAbility corresponding to the current Flutter app to the background | Method | None | `Future<void>` | Yes | Yes |

## Known Issues

None.

## Directory Structure

```text
|---- move_to_background
|     |---- android              # android adaptation code
|     |---- example              # complete example application
|     |     |---- lib            # example code
|     |     |---- ohos           # harmony project
|     |---- ios                  # ios adaptation code
|     |---- lib                  # core code implementation
|     |     |---- move_to_background.dart  # main entry file of the library
|     |---- ohos                 # harmony adaptation code
|     |     |---- src/main/ets/com/sayegh/move_to_background/MoveToBackgroundPlugin.ets  # native implementation for harmony
|     |---- test                 # unit test files
|     |---- CHANGELOG.md                 # update log
|     |---- CHANGELOG.OpenHarmony.md     # harmony version update log
|     |---- README.OpenSource.md         # open source description
|     |---- README.OpenHarmony.md        # English documentation
|     |---- README.OpenHarmony_CN.md     # Chinese documentation
|     |---- pubspec.yaml                 # configuration file
```

## Contributing

If you encounter any problems during use, feel free to open an [Issue](https://gitcode.com/org/OpenHarmony-Flutter/move_to_background/issues). PRs are also very welcome to help build this project.

## Open Source License

This project is based on [MIT](https://github.com/Sayegh7/move_to_background/blob/master/LICENSE). Please feel free to enjoy and participate in open source.
