import 'package:flutter/cupertino.dart';

class ProductModel with ChangeNotifier {
  final String id, title, imageUrl, productCategoryName, model;
  final double price;
  final int quantity;

  ProductModel({
    required this.id,
    required this.title,
    required this.model,
    required this.imageUrl,
    required this.productCategoryName,
    required this.price,
    required this.quantity,
  });
}
