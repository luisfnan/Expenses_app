import 'package:flutter/material.dart';

enum Category {
 food, travel, car, electricity, other
}

const categoryIcons = {
 Category.food: Icons.lunch_dining,
 Category.travel: Icons.flight_takeoff,
 Category.car: Icons.car_repair,
 Category.electricity: Icons.electric_bolt,
 Category.other: Icons.arrow_forward_ios
};