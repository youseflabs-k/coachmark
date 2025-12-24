<div align="center">

# 🎯 Coachmark

[![pub package](https://img.shields.io/pub/v/coachmark.svg?color=blue&label=pub.dev)](https://pub.dev/packages/coachmark)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-3.24%2B-blue.svg?style=flat&logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.5%2B-blue.svg?style=flat&logo=dart)](https://dart.dev)

**Beautiful, customizable coach marks and onboarding overlays for Flutter**  
*Create stunning product tours with dynamic target highlighting*

[Installation](#-installation) •
[Quick Start](#-quick-start) •
[Features](#-features) •
[Examples](#-examples) •
[API Reference](#-api-reference)

</div>

---

## 📸 Screenshots

<p align="center">
  <img src="screenshots/screenshot-1.png" width="250" alt="Step 1" />
  <img src="screenshots/screenshot-2.png" width="250" alt="Step 2" />
  <img src="screenshots/screenshot-3.png" width="250" alt="Step 3" />
</p>

---

---

## ✨ Features

- 🎯 **Dynamic Highlighting** - Wrap any widget to highlight it with a coach mark overlay
- 🎨 **Fully Customizable** - Control colors, sizes, borders, shadows, and positioning
- 📱 **Smart Positioning** - Automatically adjusts bubble position based on available screen space
- 🧭 **Position Control** - Auto-detect the best position or manually specify preferred placement
- 🌗 **Dimmed Overlay** - Creates focus by dimming the background with a cut-out hole
- 📦 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  coachmark: ^0.1.0
```

Then run:

```bash
flutter pub get
```

> **Latest Version:** Check [pub.dev](https://pub.dev/packages/coachmark) for the most recent version.

---

## 🚀 Quick Start

### 1. Import the Package

```dart
import 'package:coachmark/coachmark.dart';
```

### 2. Wrap Your Widget

```dart
Coachmark(
  isVisible: true,
  config: CoachmarkConfig(
    description: 'Tap this button to perform an action!',
  ),
  onDismiss: () {
    // Handle dismiss
  },
  child: ElevatedButton(
    onPressed: () {},
    child: Text('My Button'),
  ),
)
```

That's it! Your first coachmark is ready. 🎉

---

## 📚 Examples

### Basic Usag

```bash
flutter pub get
```

## Usage

### Basic Example

```dart
import 'package:flutter/material.dart';
import 'package:coachmark/coachmark.dart';

class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool _showCoachmark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Coachmark Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Coachmark(
              isVisible: _showCoachmark,
              config: CoachmarkConfig(
                description: 'Tap this button to perform an action!',
                highlightBorderColor: Colors.blue,
                bubbleBackgroundColor: Colors.white,
              ),
              onDismiss: () {
                setState(() => _showCoachmark = false);
              },
              child: ElevatedButton(
                onPressed: () {},
                child: Text('My Button'),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                setState(() => _showCoachmark = true);
              },
              child: Text('Show Coachmark'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Advanced Configuration

```dart
Coachmark(
  isVisible: true,
  config: CoachmarkConfig(
    description: 'This is an important feature you should know about!',
    descriptionStyle: TextStyle(
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    bubbleBackgroundColor: Color(0xFF2C3E50),
    bubbleBorderColor: Colors.blueAccent,
    highlightBorderColor: Colors.greenAccent,
    highlightBorderWidth: 3.0,
    highlightCornerRadius: 16.0,
    bubbleCornerRadius: 12.0,
    bubblePadding: EdgeInsets.all(20.0),
    bubbleMaxWidth: 350.0,
    overlayColor: Color(0xAA000000),
    spacing: 16.0,
    preferredPosition: CoachmarkBubblePosition.bottom,
    bubbleShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 20,
        offset: Offset(0, 10),
      ),
    ],
  ),
  onDismiss: () {
    print('Coachmark dismissed');
  },
  child: YourWidget(),
)
```

### Sequential Coachmarks

You can create a tour by showing multiple coachmarks in sequence:

```dart
class OnboardingTour extends StatefulWidget {
  @override
  State<OnboardingTour> createState() => _OnboardingTourState();
}

class _OnboardingTourState extends State<OnboardingTour> {
  int _currentStep = 0;

  void _nextStep() {
    setState(() {
      if (_currentStep < 2) {
        _currentStep++;
      } else {
        _currentStep = -1; // Hide all
      }
    });
  }

  @override
  Widget build(BuildContext context) {
---

## 📖 API Reference

### Coachmark Widget

```dart
Coachmark({
  required Widget child,
  required CoachmarkConfig config,
  bool isVisible = false,
  VoidCallback? onDismiss,
  GlobalKey? childKey,
})
```

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `child` | `Widget` | ✅ Yes | The widget to be highlighted |
| `config` | `CoachmarkConfig` | ✅ Yes | Configuration for appearance and behavior |
| `isVisible` | `bool` | No | Whether to show the coachmark (default: `false`) |
| `onDismiss` | `VoidCallback?` | No | Called when the overlay is dismissed |
| `childKey` | `GlobalKey?` | No | Optional key for the child widget |

### CoachmarkConfig

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `description` | `String` | Required | Text shown in the bubble |
| `descriptionStyle` | `TextStyle?` | `null` | Style for the description text |
| `bubbleBackgroundColor` | `Color` | `Colors.white` | Background color of the bubble |
| `bubbleBorderColor` | `Color?` | `null` | Border color of the bubble |
| `highlightBorderColor` | `Color` | `Colors.green` | Border color around the target |
| `highlightBorderWidth` | `double` | `2.0` | Border width around the target |
| `highlightCornerRadius` | `double` | `12.0` | Corner radius of the highlight |
| `highlightPadding` | `EdgeInsets` | `EdgeInsets.zero` | Padding around the highlighted target |
| `bubbleCornerRadius` | `double` | `12.0` | Corner radius of the bubble |
| `bubblePadding` | `EdgeInsets` | `EdgeInsets.all(16.0)` | Padding inside the bubble |
| `bubbleMaxWidth` | `double` | `300.0` | Maximum width of the bubble |
| `overlayColor` | `Color` | `Color(0x8C000000)` | Dim overlay background color |
| `bubbleShadow` | `List<BoxShadow>?` | `null` | Shadow for the bubble |
| `spacing` | `double` | `12.0` | Space between target and bubble |
| `preferredPosition` | `CoachmarkBubblePosition` | `auto` | Preferred bubble position |
| `drawOverSafeArea` | `bool` | `false` | Whether bubble can draw over safe areas |

### CoachmarkBubblePosition

```dart
enum CoachmarkBubblePosition {
  auto,    // Automatically choose the best position
  left,    // Place bubble to the left of the target
  right,   // Place bubble to the right of the target
  top,     // Place bubble above the target
  bottom,  // Place bubble below the target
}
```

---

## 💡 Best Practices

### ✅ Do's

- ✅ Use sequential coachmarks to guide users through complex flows
- ✅ Keep descriptions short and actionable (under 50 words)
- ✅ Test your coachmarks on different screen sizes
- ✅ Use `highlightPadding` to add breathing room around small targets
- ✅ Dismiss coachmarks on user interaction for better UX
- ✅ Use `GlobalKey` when highlighting widgets in complex layouts

### ❌ Don'ts

- ❌ Don't show too many coachmarks at once (3-5 max per tour)
- ❌ Don't block critical UI interactions with coachmarks
- ❌ Don't use tiny font sizes that are hard to read
- ❌ Don't forget to handle coachmark state properly
- ❌ Don't show the same coachmark repeatedly to returning users

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

```
MIT License

Copyright (c) 2025 Ahmed Yousef

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 🔗 Links

- **Repository:** [github.com/youseflabs-k/coachmark](https://github.com/youseflabs-k/coachmark)
- **Issues:** [github.com/youseflabs-k/coachmark/issues](https://github.com/youseflabs-k/coachmark/issues)
- **pub.dev:** [pub.dev/packages/coachmark](https://pub.dev/packages/coachmark)
- **Example App:** [example/](example/)

---

<div align="center">

**Made with ❤️ by [Ahmed Yousef](https://github.com/youseflabs-k)**

If you find this package helpful, please consider giving it a ⭐️!

</div>ehavior |
| isVisible | bool | No | Whether to show the coachmark (default: false) |
| onDismiss | VoidCallback? | No | Called when the overlay is dismissed |
| childKey | GlobalKey? | No | Optional key for the child widget |

### CoachmarkConfig

| Property | Type | Default | Description |
| ---------- | ------ | --------- | ------------- |
| description | String | Required | Text shown in the bubble |
| descriptionStyle | TextStyle? | null | Style for the description text |
| bubbleBackgroundColor | Color | Colors.white | Background color of the bubble |
| bubbleBorderColor | Color? | null | Border color of the bubble |
| highlightBorderColor | Color | Colors.green | Border color around the target |
| highlightBorderWidth | double | 2.0 | Border width around the target |
| highlightCornerRadius | double | 12.0 | Corner radius of the highlight |
| bubbleCornerRadius | double | 12.0 | Corner radius of the bubble |
| bubblePadding | EdgeInsets | EdgeInsets.all(16.0) | Padding inside the bubble |
| bubbleMaxWidth | double | 300.0 | Maximum width of the bubble |
| overlayColor | Color | Color(0x8C000000) | Dim overlay background color |
| bubbleShadow | List<BoxShadow>? | null | Shadow for the bubble |
| spacing | double | 12.0 | Space between target and bubble |
| preferredPosition | CoachmarkBubblePosition | auto | Preferred bubble position |

### CoachmarkBubblePosition

- `auto` - Automatically choose the best position
- `left` - Place bubble to the left of the target
- `right` - Place bubble to the right of the target
- `top` - Place bubble above the target
- `bottom` - Place bubble below the target

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
