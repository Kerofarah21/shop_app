// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

class HomeModel {
  bool? status;
  HomeData? data;

  HomeModel(Map<String, dynamic> response) {
    status = response['status'];
    data = HomeData(response['data']);
  }
}

class HomeData {
  List<Banner>? banners = [];
  List<Product>? products = [];

  HomeData(Map<String, dynamic> data) {
    data['banners'].forEach((banner) => banners!.add(Banner(banner)));
    data['products'].forEach((product) => products!.add(Product(product)));
  }
}

class Banner {
  int? id;
  String? image;

  Banner(Map<String, dynamic> banner) {
    id = banner['id'];
    image = banner['image'];
  }
}

class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  Product(Map<String, dynamic> product) {
    id = product['id'];
    price = product['price'];
    oldPrice = product['old_price'];
    discount = product['discount'];
    image = product['image'];
    name = product['name'];
    inFavorites = product['in_favorites'];
    inCart = product['in_cart'];
  }
}
