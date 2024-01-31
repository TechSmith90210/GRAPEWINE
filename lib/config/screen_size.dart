import 'package:flutter/material.dart';

EdgeInsets calculateMargin(double screenHeight, double screenWidth) {
  double smallScreenThreshold = 600;
  double mediumScreenThreshold = 800;

  if (screenHeight < smallScreenThreshold &&
      screenWidth < smallScreenThreshold) {
    // Small screen
    return EdgeInsets.only(left: 16, right: 16);
  } else if ((screenHeight >= smallScreenThreshold &&
          screenHeight < mediumScreenThreshold) ||
      (screenWidth >= smallScreenThreshold &&
          screenWidth < mediumScreenThreshold)) {
    // Medium screen
    return EdgeInsets.only(left: 16, right: 16);
  } else {
    // Large screen
    return EdgeInsets.only(left: 16, right: 16);
  }
}
