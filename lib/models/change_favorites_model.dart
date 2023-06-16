class ChangeFavoritesModel {
  bool? status;
  String? message;

  ChangeFavoritesModel(Map<String, dynamic> response) {
    status = response['status'];
    message = response['message'];
  }
}
