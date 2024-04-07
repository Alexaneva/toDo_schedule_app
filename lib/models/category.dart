import 'dart:ui';

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});
}

class Habit {
  final int id;
  final String name;
  final int categoryId;
  bool isCompleted;
  final String image;
  final Color color;

  Habit(
      {required this.id,
      required this.name,
      required this.categoryId,
      required this.isCompleted,
      required this.image,
      required this.color});
}
