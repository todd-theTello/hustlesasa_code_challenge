import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Scales the child widget by a when it is pressed
class CustomAnimatedScale extends StatelessWidget {
  /// buukmenow animated scale constructor
  const CustomAnimatedScale({
    required this.onPressed,
    required this.child,
    this.onLongPress,
    this.animatedScale,
    super.key,
  });

  /// Function to perform on long press
  final VoidCallback? onLongPress;

  /// Function to perform on press
  final VoidCallback onPressed;

  /// Child widget of the scale
  final Widget child;

  /// optional scale value, if null, a value of 0.95 is used
  final double? animatedScale;
  @override
  Widget build(BuildContext context) {
    /// Pressed value notifier to be controlled by the gesture detector
    /// This value controls how the animated container reacts to screen taps
    final ValueNotifier<bool> isPressed = ValueNotifier(false);
    return ValueListenableBuilder(
      valueListenable: isPressed,
      builder: (context, pressed, _) {
        return GestureDetector(
          onTapDown: (_) {
            /// Make a haptic feedback when the Widget is pressed
            /// Then set the value of isPressed to true
            HapticFeedback.mediumImpact();
            isPressed.value = true;
          },
          onTapUp: (_) {
            /// Set the value of isPressed to false when the widget is longer being pressed
            isPressed.value = false;
          },
          onTapCancel: () {
            /// Set the value of isPressed to false when the widget tap is canceled
            isPressed.value = false;
          },
          onTap: onPressed,
          onLongPress: onLongPress,
          child: AnimatedScale(
            scale: pressed ? animatedScale ?? 0.95 : 1,
            duration: const Duration(milliseconds: 200),
            child: child,
          ),
        );
      },
    );
  }
}
