class SensorThresholds {
  // Gait & Steps
  static const double stepMagnitude = 12.0;
  static const double stepValley = 8.0;
  
  // Falls
  static const double freefallG = 0.5;
  static const double impactG = 3.0;

  // Stability
  static const double stableVariance = 0.5;
  static const double cautionVariance = 2.0;
  static const double unstableVariance = 5.0;

  // Impact (G-Force)
  static const double lowImpact = 1.5;
  static const double medImpact = 2.5;
  static const double highImpact = 4.0;
}