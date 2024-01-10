import 'package:flutter/material.dart';

/// Extension on widgets
extension T on Widget {
  ///
  Widget get expanded => Expanded(child: this);

  ///
  Widget expandedWithFlex({int? flex}) => Expanded(flex: flex ?? 1, child: this);
}
