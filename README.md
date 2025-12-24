# Coachmark

A Flutter package for creating beautiful, customizable coach marks and onboarding overlays with dynamic target highlighting.

## Screenshots

<p align="center">
  <img src="screenshots/screenshot-1.png" width="250" alt="Step 1" />
  <img src="screenshots/screenshot-2.png" width="250" alt="Step 2" />
  <img src="screenshots/screenshot-3.png" width="250" alt="Step 3" />
</p>

## Features

- ✨ **Dynamic Highlighting**: Wrap any widget to highlight it with a coach mark overlay
- 🎨 **Fully Customizable**: Control colors, sizes, borders, shadows, and positioning
- 📱 **Responsive**: Automatically adjusts bubble position based on available screen space
- 🎯 **Smart Positioning**: Auto-detect the best position or manually specify preferred placement
- 🌗 **Dimmed Overlay**: Creates focus by dimming the background with a cut-out hole
- 🔧 **Easy Integration**: Simple widget-based API

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  coachmark: ^0.1.0
```

Then run:

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
    return Scaffold(
      body: Column(
        children: [
          Coachmark(
            isVisible: _currentStep == 0,
            config: CoachmarkConfig(
              description: 'Step 1: This is the first feature',
            ),
            onDismiss: _nextStep,
            child: Container(/* ... */),
          ),
          Coachmark(
            isVisible: _currentStep == 1,
            config: CoachmarkConfig(
              description: 'Step 2: This is the second feature',
            ),
            onDismiss: _nextStep,
            child: Container(/* ... */),
          ),
          Coachmark(
            isVisible: _currentStep == 2,
            config: CoachmarkConfig(
              description: 'Step 3: This is the final feature',
            ),
            onDismiss: _nextStep,
            child: Container(/* ... */),
          ),
        ],
      ),
    );
  }
}
```

## API Reference

### Coachmark Widget

| Property | Type | Required | Description |
| ---------- | ------ | ---------- | ------------- |
| child | Widget | Yes | The widget to be highlighted |
| config | CoachmarkConfig | Yes | Configuration for appearance and behavior |
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
