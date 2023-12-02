import 'dart:math';

double getBmi(String weight, String height) {
  double w = double.tryParse(weight) ?? 0;
  double h = (double.tryParse(height) ?? 100) / 100;
  return w / pow(h, 2);
}

String getBmiRuselt(String gender, double bmi) {
  if (gender == "male") {
    if (bmi < 18.5) {
      return "underweight";
    } else if (bmi < 25) {
      return "normal weight";
    } else if (bmi < 30) {
      return "overweight";
    } else {
      return "obese";
    }
  } else if (gender == "female") {
    if (bmi < 18.5) {
      return "underweight";
    } else if (bmi < 25) {
      return "normal weight";
    } else if (bmi < 30) {
      return "overweight";
    } else {
      return "obese";
    }
  }
  return 'unavailable';
}
