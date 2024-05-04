import 'package:ecommerce_mobile_app/models/products_model.dart';
import 'package:ecommerce_mobile_app/providers/products_provider.dart';
import 'package:ecommerce_mobile_app/services/utils.dart';
import 'package:ecommerce_mobile_app/widgets/product_items.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategorieScreen extends StatefulWidget {
  final String catText;
  const CategorieScreen({super.key, required this.catText});

  @override
  State<CategorieScreen> createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
  @override
  void initState() {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    productsProvider.fetchProductsCategoryFilter(widget.catText);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    Size size = utils.getScreenSize;

    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productProviders.getProducts;
    // final arguments = (ModalRoute.of(context)?.settings.arguments ??
    //     <String, dynamic>{}) as Map;
    // final title = arguments['title'];

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.catText),
        ),
        body: SingleChildScrollView(
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: size.width / (size.height * 0.65),
            children: List.generate(allProducts.length, (index) {
              return ChangeNotifierProvider.value(
                value: allProducts[index],
                child: const ProductsWidget(),
              );
            }),
          ),
        ));
  }
}
