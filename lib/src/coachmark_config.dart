import 'package:flutter/material.dart';

/// Configuration for the coachmark appearance and behavior
class CoachmarkConfig {
  /// The description text to show in the bubble
  final String description;
  
  /// Text style for the description
  final TextStyle? descriptionStyle;
  
  /// Background color of the description bubble
  final Color bubbleBackgroundColor;
  
  /// Border color of the description bubble
  final Color? bubbleBorderColor;
  
  /// Border color of the highlighted target
  final Color highlightBorderColor;
  
  /// Border width of the highlighted target
  final double highlightBorderWidth;
  
  /// Corner radius of the highlighted target
  final double highlightCornerRadius;
  
  /// Padding around the highlighted target (expands the highlight area)
  final EdgeInsets highlightPadding;
  
  /// Corner radius of the description bubble
  final double bubbleCornerRadius;
  
  /// Padding inside the description bubble
  final EdgeInsets bubblePadding;
  
  /// Maximum width of the description bubble
  final double bubbleMaxWidth;
  
  /// Overlay dim color (background darkness)
  final Color overlayColor;
  
  /// Shadow for the description bubble
  final List<BoxShadow>? bubbleShadow;
  
  /// Spacing between the target and the bubble
  final double spacing;
  
  /// Preferred position of the bubble relative to target
  final CoachmarkBubblePosition preferredPosition;
  
  /// Whether to draw over safe areas (notches, status bars, etc.)
  /// When false (default), the overlay respects safe areas
  final bool drawOverSafeArea;

  const CoachmarkConfig({
    required this.description,
    this.descriptionStyle,
    this.bubbleBackgroundColor = Colors.white,
    this.bubbleBorderColor,
    this.highlightBorderColor = Colors.green,
    this.highlightBorderWidth = 2.0,
    this.highlightCornerRadius = 12.0,
    this.highlightPadding =  EdgeInsets.zero,
    this.bubbleCornerRadius = 12.0,
    this.bubblePadding = const EdgeInsets.all(16.0),
    this.bubbleMaxWidth = 300.0,
    this.overlayColor = const Color(0x8C000000),
    this.bubbleShadow,
    this.spacing = 12.0,
    this.preferredPosition = CoachmarkBubblePosition.auto,
    this.drawOverSafeArea = false,
  });

  CoachmarkConfig copyWith({
    String? description,
    TextStyle? descriptionStyle,
    Color? bubbleBackgroundColor,
    Color? bubbleBorderColor,
    Color? highlightBorderColor,
    double? highlightBorderWidth,
    double? highlightCornerRadius,
    EdgeInsets? highlightPadding,
    double? bubbleCornerRadius,
    EdgeInsets? bubblePadding,
    double? bubbleMaxWidth,
    Color? overlayColor,
    List<BoxShadow>? bubbleShadow,
    double? spacing,
    CoachmarkBubblePosition? preferredPosition,
    bool? drawOverSafeArea,
  }) {
    return CoachmarkConfig(
      description: description ?? this.description,
      descriptionStyle: descriptionStyle ?? this.descriptionStyle,
      bubbleBackgroundColor: bubbleBackgroundColor ?? this.bubbleBackgroundColor,
      bubbleBorderColor: bubbleBorderColor ?? this.bubbleBorderColor,
      highlightBorderColor: highlightBorderColor ?? this.highlightBorderColor,
      highlightBorderWidth: highlightBorderWidth ?? this.highlightBorderWidth,
      highlightCornerRadius: highlightCornerRadius ?? this.highlightCornerRadius,
      highlightPadding: highlightPadding ?? this.highlightPadding,
      bubbleCornerRadius: bubbleCornerRadius ?? this.bubbleCornerRadius,
      bubblePadding: bubblePadding ?? this.bubblePadding,
      bubbleMaxWidth: bubbleMaxWidth ?? this.bubbleMaxWidth,
      overlayColor: overlayColor ?? this.overlayColor,
      bubbleShadow: bubbleShadow ?? this.bubbleShadow,
      spacing: spacing ?? this.spacing,
      preferredPosition: preferredPosition ?? this.preferredPosition,
      drawOverSafeArea: drawOverSafeArea ?? this.drawOverSafeArea,
    );
  }
}

/// Position preference for the description bubble
enum CoachmarkBubblePosition {
  /// Automatically choose the best position based on available space
  auto,
  /// Place bubble to the left of the target
  left,
  /// Place bubble to the right of the target
  right,
  /// Place bubble above the target
  top,
  /// Place bubble below the target
  bottom,
}
