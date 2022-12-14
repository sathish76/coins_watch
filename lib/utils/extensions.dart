import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ExtendedBuildContext on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension ExtendedString on String {
  String get readablePrice {
    final n = double.parse(this);
    NumberFormat numberFormat = new NumberFormat.compactCurrency(symbol: r'$');
    return numberFormat.format(n);
  }

  String get readablePercentage {
    final n = double.parse(this);
    return n.toStringAsFixed(2);
  }
}

extension ExtendedDateTime on DateTime {
  int get startOfTheDayUtcEpoch {
    final last24Hours = DateTime.now().subtract(Duration(hours: 24));
    return last24Hours.toUtc().millisecondsSinceEpoch;
  }
}

extension Round on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}
