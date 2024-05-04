import 'package:ecommerce_mobile_app/models/products_model.dart';
import 'package:ecommerce_mobile_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductScreen extends StatelessWidget {
  final ProductModel product;
  const ProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    NumberFormat formatter = NumberFormat.decimalPatternDigits(
      locale: 'en_us',
    );

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
                height: 50,
                child: FilledButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                  child: TextWidget(
                    text: 'Add to cart',
                    color: Colors.white,
                    textSize: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
