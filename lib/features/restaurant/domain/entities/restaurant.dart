import 'package:flutter/material.dart';
import 'package:setel/features/restaurant/domain/entities/working_days.dart';

class Restaurant {
  Restaurant({
    @required this.restaurantName,
    this.workindDays,
    this.isOpen,
  });

  final String restaurantName;

  List<WorkingDay> workindDays;
  bool isOpen;
}
