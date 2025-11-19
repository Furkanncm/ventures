import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  Size get sizeOf => MediaQuery.sizeOf(this);
  double get screenHeight => sizeOf.height;
  double get screenWidth => sizeOf.width;

  double dynamicHeight(double value) =>
      value > 1.0 ? screenHeight*0.1 : screenHeight * value;
  
  double dynamicWidth(double value) => 
      value > 1.0 ? screenWidth*0.1 : screenWidth * value;
}
