import 'package:flutter/material.dart';

class Category {
  int id;
  String categoryName;
  String description;
  String iconPath;
  bool useForCashFlow = true;
  Category({
    @required this.id,
    @required this.categoryName,
    @required this.description,
    @required this.iconPath,
    this.useForCashFlow = true,
  });
}
