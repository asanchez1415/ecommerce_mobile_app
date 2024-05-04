import 'package:ecommerce_mobile_app/models/products_model.dart';
import 'package:ecommerce_mobile_app/widgets/text_widget.dart';
import 'package:ecommerce_mobile_app/consts/firebase_consts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../providers/cart_provider.dart';
import '../services/global_methods.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  final ProductModel product;
  const ProductScreen({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    NumberFormat formatter = NumberFormat.decimalPatternDigits(
      locale: 'en_us',
    );
    final cartProvider = Provider.of<CartProvider>(context);
    bool? _isInCart = cartProvider.getCartItems.containsKey(product.id);
    final _quantityTextController = TextEditingController();
    _quantityTextController.text = '1';
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          text: '${product.title} ${product.model}',
          textSize: 25,
          color: Colors.white,
          isTitle: true,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              ClipRRect(
                child: Image.network(product.imageUrl),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: '\$ ${(formatter.format(product.price))}',
                    color: Colors.white,
                    textSize: 30,
                  ),
                  Row(
                    children: [
                      TextWidget(
                        text: 'QTY',
                        color: Colors.white,
                        textSize: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextWidget(
                        text: product.quantity.toString(),
                        color: Colors.white,
                        textSize: 30,
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                      text: 'Type car:', color: Colors.white, textSize: 20),
                  TextWidget(
                      text: product.productCategoryName,
                      color: Colors.white,
                      textSize: 20),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.1),
                  child: TextButton(
                    onPressed: _isInCart
                        ? null
                        : () async {
                            final User? user = authInstance.currentUser;

                            if (user == null) {
                              GlobalMethods.errorDialog(
                                  subtitle: 'No user found, Please login first',
                                  context: context);
                              return;
                            }
                            await GlobalMethods.addToCart(
                                productId: product.id,
                                quantity:
                                    int.parse(_quantityTextController.text),
                                context: context);
                            await cartProvider.fetchCart();
                          },
                    child: TextWidget(
                      text: _isInCart ? 'In cart' : 'Add to cart',
                      maxLines: 1,
                      color: Colors.white,
                      textSize: 20,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.grey),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12.0),
                            bottomRight: Radius.circular(12.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
