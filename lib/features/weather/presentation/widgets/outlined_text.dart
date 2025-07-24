/*
 * @Author: Bon Ryan
 * @Created: 2025-07-24
 * @Page: outlined_text
 * @Description: This file defines the OutlinedText widget for displaying text with an outline.
 * It is used to enhance the visibility of text in various UI components.
 * The OutlinedText widget is customizable with parameters for text style, outline color, and outline width.
 * It is part of the weather presentation layer and is used to display text in a visually appealing way.
 * It is used in various weather-related screens to provide a modern and sleek design.
 * 
 * 
 * @Usage:
 * OutlinedText(
 *   text: 'Hello World',
 *   style: TextStyle(fontSize: 24, color: Colors.white),
 *   outlineColor: Colors.black,
 *   outlineWidth: 2.0, 
 * *   textAlign: TextAlign.center,
 * );
 * 
 * @Note: This widget can be used in any Flutter application to display outlined text.
 */ 

import 'package:flutter/material.dart';

class OutlinedText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color fillColor;
  final Color strokeColor;
  final double strokeWidth;

  const OutlinedText({
    super.key,
    required this.text,
    this.fontSize = 42,
    this.fontWeight = FontWeight.bold,
    this.fillColor = Colors.white,
    this.strokeColor = Colors.black,
    this.strokeWidth = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Stroke
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),
        // Fill
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: fillColor,
          ),
        ),
      ],
    );
  }
}
