import 'package:ecommerce_mobile_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    Key? key,
    required this.price,
    required this.textPrice,
  }) : super(key: key);
  final double price;
  final String textPrice;

  @override
  Widget build(BuildContext context) {
    NumberFormat formatter = NumberFormat.decimalPatternDigits(
      locale: 'en_us',
    );

    return FittedBox(
        child: Row(
      children: [
        TextWidget(
          text: '\$${(formatter.format(price))}',
          color: Colors.white,
          textSize: 20,
        ),
      ],
    ));
  }
}
