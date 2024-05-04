import 'package:ecommerce_mobile_app/screens/product_screen.dart';
import 'package:ecommerce_mobile_app/widgets/price_widget.dart';
import 'package:ecommerce_mobile_app/widgets/text_widget.dart';
import 'package:ecommerce_mobile_app/consts/firebase_consts.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../providers/cart_provider.dart';
import '../models/products_model.dart';
import '../services/global_methods.dart';
import '../services/utils.dart';

class ProductsWidget extends StatefulWidget {
  const ProductsWidget({Key? key}) : super(key: key);

  @override
  State<ProductsWidget> createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {
  final _quantityTextController = TextEditingController();
  @override
  void initState() {
    _quantityTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool? _isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    final _quantityTextController = TextEditingController();
    _quantityTextController.text = '1';
    final product = Provider.of<ProductModel>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductScreen(product: product),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              Expanded(
                // Add Expanded here
                child: FancyShimmerImage(
                  imageUrl: product.imageUrl,
                  height: size.width * 0.28,
                  width: size.width * 0.27,
                  boxFit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: product.title,
                      color: Colors.white,
                      textSize: 20,
                      isTitle: true,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: product.model,
                      color: Colors.white,
                      textSize: 18,
                      isTitle: true,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: PriceWidget(
                        price: product.price,
                        textPrice: _quantityTextController.text,
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            flex: 6,
                            child: FittedBox(
                              child: TextWidget(
                                text: 'QTY',
                                color: Colors.white,
                                textSize: 20,
                                isTitle: true,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            flex: 4,
                            child: FittedBox(
                              child: TextWidget(
                                text: product.quantity.toString(),
                                color: Colors.white,
                                textSize: 18,
                                isTitle: true,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
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
                                productId: productModel.id,
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
