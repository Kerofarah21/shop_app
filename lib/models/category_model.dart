// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

class CategoryModel {
  bool? status;
  CategoryData? data;

  CategoryModel(Map<String, dynamic> response) {
    status = response['status'];
    data = CategoryData(response['data']);
  }
}

class CategoryData {
  List<Category> categories = [];

  CategoryData(Map<String, dynamic> data) {
    data['data'].forEach((category) {
      categories.add(Category(category));
    });
  }
}

class Category {
  int? id;
  String? name;
  String? image;

  Category(Map<String, dynamic> category) {
    id = category['id'];
    name = category['name'];
    image = category['image'];
  }
}
