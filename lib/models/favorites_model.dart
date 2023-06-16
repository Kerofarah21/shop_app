class FavoritesModel {
  bool? status;
  FavoritesData? data;

  FavoritesModel(Map<String, dynamic> response) {
    status = response['status'];
    data = FavoritesData(response['data']);
  }
}

class FavoritesData {
  List<Favorite> favorites = [];

  FavoritesData(Map<String, dynamic> data) {
    data['data'].forEach((favorite) => favorites.add(Favorite(favorite)));
  }
}

class Favorite {
  int? id;
  Product? product;

  Favorite(Map<String, dynamic> favorite) {
    id = favorite['id'];
    product = Product(favorite['product']);
  }
}

class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;

  Product(Map<String, dynamic> product) {
    id = product['id'];
    price = product['price'];
    oldPrice = product['old_price'];
    discount = product['discount'];
    image = product['image'];
    name = product['name'];
  }
}
