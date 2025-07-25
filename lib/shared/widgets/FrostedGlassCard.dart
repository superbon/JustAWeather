/*
 * @Author: Bon Ryan
 * @Created: 2025-07-24
 * @Page: FrostedGlassCard
 * @Description: This file defines the FrostedGlassCard widget for creating a frosted glass effect card.
 * It is used to enhance the visual appearance of cards in the weather presentation layer.
 * The FrostedGlassCard widget is used to create a visually appealing card with a frosted glass effect.
 * It is part of the weather presentation layer and is used to display weather information in a stylish way.
 * It is used in various weather-related screens to provide a modern and sleek design.
 */

import 'dart:ui';
import 'package:flutter/material.dart';

class FrostedGlassCard extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;

  const FrostedGlassCard({
    Key? key,
    required this.child,
    this.width = 100,
    this.height = 150,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color baseColor = theme.colorScheme.surface;

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: baseColor.withOpacity(0.16), // Glassy overlay
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: baseColor.withOpacity(0.28),
              width: 1.2,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
