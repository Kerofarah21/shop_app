class SearchModel {
  bool? status;
  SearchData? data;

  SearchModel(Map<String, dynamic> response) {
    status = response['status'];
    data = SearchData(response['data']);
  }
}

class SearchData {
  List<Product> products = [];

  SearchData(Map<String, dynamic> data) {
    data['data'].forEach((product) => products.add(Product(product)));
  }
}

class Product {
  int? id;
  dynamic price;
  String? image;
  String? name;

  Product(Map<String, dynamic> product) {
    id = product['id'];
    price = product['price'];
    image = product['image'];
    name = product['name'];
  }
}
