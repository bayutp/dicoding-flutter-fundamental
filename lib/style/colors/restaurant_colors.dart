import 'package:flutter/material.dart';

enum RestaurantColors {
  white("White", Colors.white),
  amber("Amber", Color(0xFFEDB82C)),
  green("Green", Color(0xFF22BA61)),
  grey("Grey", Color(0xFFABABAB)),
  header("Header", Colors.black),
  button("Button", Color(0xFF1D1D1D)),
  content("Content", Color(0xFF353535)),
  address("Address", Color(0xFF0A6FE6));

  const RestaurantColors(this.name, this.colors);
  final String name;
  final Color colors;
}
