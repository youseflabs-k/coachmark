# Coachmark Example App

This is a demonstration app showing how to use the coachmark package in a Flutter application.

## Features Demonstrated

- **Interactive Tour**: A 3-step tour that highlights different UI elements
- **Custom Styling**: Different bubble colors for different coachmarks
- **User Controls**: Skip and Next buttons to navigate the tour
- **Help Icon**: Users can restart the tour anytime

## Running the Example

### Prerequisites

- Flutter SDK installed
- Android Studio or VS Code with Flutter extension
- Android device or emulator

### Steps to Run

1. Navigate to the example directory:

   ```bash
   cd example
   ```

2. Get dependencies:

   ```bash
   flutter pub get
   ```

3. Run the app:

   ```bash
   flutter run
   ```

## Code Structure

The example demonstrates:

- Using `GlobalKey` to reference widgets for highlighting
- Managing coachmark visibility with state
- Creating sequential tour steps
- Customizing coachmark appearance

## Try It Out

1. Launch the app
2. Tap the help icon in the app bar
3. Follow the tour through the three steps
4. Try incrementing the counter during or after the tour
