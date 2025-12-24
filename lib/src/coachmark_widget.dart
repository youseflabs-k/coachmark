import 'package:flutter/material.dart';
import 'coachmark_config.dart';

/// A widget that wraps a child and can show a coachmark overlay
/// highlighting that child with an explanatory description.
class Coachmark extends StatefulWidget {
  /// The widget to be highlighted
  final Widget child;
  
  /// Configuration for the coachmark appearance
  final CoachmarkConfig config;
  
  /// Whether the coachmark overlay is currently visible
  final bool isVisible;
  
  /// Callback when the overlay is dismissed
  final VoidCallback? onDismiss;
  
  /// Optional key for the child widget
  final GlobalKey? childKey;

  const Coachmark({
    super.key,
    required this.child,
    required this.config,
    this.isVisible = false,
    this.onDismiss,
    this.childKey,
  });

  @override
  State<Coachmark> createState() => _CoachmarkState();
}

class _CoachmarkState extends State<Coachmark> {
  final GlobalKey _targetKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  GlobalKey get _effectiveKey => widget.childKey ?? _targetKey;

  @override
  void didUpdateWidget(Coachmark oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible != oldWidget.isVisible) {
      if (widget.isVisible) {
        _showOverlay();
      } else {
        _hideOverlay();
      }
    }
  }

  @override
  void dispose() {
    _hideOverlay();
    super.dispose();
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;

    // Wait for the next frame to ensure the widget is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? renderBox =
          _effectiveKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null || !mounted) return;

      final Offset position = renderBox.localToGlobal(Offset.zero);
      final Size size = renderBox.size;
      final EdgeInsets padding = widget.config.highlightPadding;
      final Rect targetRect = Rect.fromLTRB(
        position.dx - padding.left,
        position.dy - padding.top,
        position.dx + size.width + padding.right,
        position.dy + size.height + padding.bottom,
      );

      _overlayEntry = OverlayEntry(
        builder: (context) => _CoachmarkOverlay(
          targetRect: targetRect,
          config: widget.config,
          onDismiss: () {
            _hideOverlay();
            widget.onDismiss?.call();
          },
        ),
      );

      Overlay.of(context).insert(_overlayEntry!);
    });
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: _effectiveKey,
      child: widget.child,
    );
  }
}

/// The overlay widget that shows the dimmed background and description bubble
class _CoachmarkOverlay extends StatelessWidget {
  final Rect targetRect;
  final CoachmarkConfig config;
  final VoidCallback onDismiss;

  const _CoachmarkOverlay({
    required this.targetRect,
    required this.config,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final Offset bubblePosition = _calculateBubblePosition(screenSize);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onDismiss,
      child: Stack(
        children: [
          // Dimmed background with hole
          Positioned.fill(
            child: CustomPaint(
              painter: _HolePainter(
                targetRect: targetRect,
                cornerRadius: config.highlightCornerRadius,
                overlayColor: config.overlayColor,
              ),
            ),
          ),

          // Highlight border around target
          Positioned(
            left: targetRect.left,
            top: targetRect.top,
            width: targetRect.width,
            height: targetRect.height,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(config.highlightCornerRadius),
                  border: Border.all(
                    color: config.highlightBorderColor,
                    width: config.highlightBorderWidth,
                  ),
                ),
              ),
            ),
          ),

          // Description bubble
          Positioned(
            left: bubblePosition.dx,
            top: bubblePosition.dy,
            child: config.drawOverSafeArea
                ? _buildBubble()
                : SafeArea(
                    child: _buildBubble(),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildBubble() {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: config.bubbleMaxWidth),
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: config.bubblePadding,
          decoration: BoxDecoration(
            color: config.bubbleBackgroundColor,
            borderRadius: BorderRadius.circular(config.bubbleCornerRadius),
            boxShadow: config.bubbleShadow ??
                [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
            border: config.bubbleBorderColor != null
                ? Border.all(color: config.bubbleBorderColor!)
                : null,
          ),
          child: Text(
            config.description,
            style: config.descriptionStyle ??
                const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
          ),
        ),
      ),
    );
  }

  Offset _calculateBubblePosition(Size screenSize) {
    final double padding = config.spacing;
    final double bubbleMaxWidth = config.bubbleMaxWidth;

    // Calculate available space in each direction
    final double spaceLeft = targetRect.left;
    final double spaceRight = screenSize.width - targetRect.right;
    final double spaceTop = targetRect.top;
    final double spaceBottom = screenSize.height - targetRect.bottom;

    CoachmarkBubblePosition position = config.preferredPosition;

    // Auto-detect best position if set to auto
    if (position == CoachmarkBubblePosition.auto) {
      if (spaceLeft > bubbleMaxWidth + padding * 2) {
        position = CoachmarkBubblePosition.left;
      } else if (spaceRight > bubbleMaxWidth + padding * 2) {
        position = CoachmarkBubblePosition.right;
      } else if (spaceBottom > 150) {
        position = CoachmarkBubblePosition.bottom;
      } else if (spaceTop > 150) {
        position = CoachmarkBubblePosition.top;
      } else {
        position = CoachmarkBubblePosition.bottom;
      }
    }

    double x = 0;
    double y = 0;

    switch (position) {
      case CoachmarkBubblePosition.left:
        x = (targetRect.left - bubbleMaxWidth - padding)
            .clamp(padding, screenSize.width - bubbleMaxWidth - padding);
        y = (targetRect.center.dy - 70)
            .clamp(padding, screenSize.height - 140);
        break;

      case CoachmarkBubblePosition.right:
        x = (targetRect.right + padding)
            .clamp(padding, screenSize.width - bubbleMaxWidth - padding);
        y = (targetRect.center.dy - 70)
            .clamp(padding, screenSize.height - 140);
        break;

      case CoachmarkBubblePosition.top:
        x = (targetRect.center.dx - bubbleMaxWidth / 2)
            .clamp(padding, screenSize.width - bubbleMaxWidth - padding);
        y = (targetRect.top - 150 - padding)
            .clamp(padding, screenSize.height - 140);
        break;

      case CoachmarkBubblePosition.bottom:
        x = (targetRect.center.dx - bubbleMaxWidth / 2)
            .clamp(padding, screenSize.width - bubbleMaxWidth - padding);
        y = (targetRect.bottom + padding)
            .clamp(padding, screenSize.height - 140);
        break;

      case CoachmarkBubblePosition.auto:
        // Already handled above
        break;
    }

    return Offset(x, y);
  }
}

/// Custom painter that creates a dimmed overlay with a transparent hole
class _HolePainter extends CustomPainter {
  final Rect targetRect;
  final double cornerRadius;
  final Color overlayColor;

  _HolePainter({
    required this.targetRect,
    required this.cornerRadius,
    required this.overlayColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Create the full background
    final Path background = Path()..addRect(Offset.zero & size);

    // Create the rounded rect hole
    final RRect hole = RRect.fromRectAndRadius(
      targetRect,
      Radius.circular(cornerRadius),
    );
    final Path cutout = Path()..addRRect(hole);

    // Use saveLayer with clear blend mode to punch a hole
    final Paint dimPaint = Paint()..color = overlayColor;
    canvas.saveLayer(Offset.zero & size, Paint());
    canvas.drawPath(background, dimPaint);
    
    final Paint clearPaint = Paint()..blendMode = BlendMode.clear;
    canvas.drawPath(cutout, clearPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _HolePainter oldDelegate) {
    return oldDelegate.targetRect != targetRect ||
        oldDelegate.cornerRadius != cornerRadius ||
        oldDelegate.overlayColor != overlayColor;
  }
}
