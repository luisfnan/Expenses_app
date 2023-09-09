import 'package:flutter/material.dart';

enum Category {
 food, travel, car, electricity, others
}

const categoryIcons = {
 Category.food: Icons.lunch_dining,
 Category.travel: Icons.flight_takeoff,
 Category.car: Icons.car_repair,
 Category.electricity: Icons.electric_bolt,
 Category.others: Icons.arrow_forward_ios
};