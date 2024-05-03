import 'package:ecommerce_mobile_app/routes/app_routes.dart';
import 'package:ecommerce_mobile_app/services/utils.dart';
import 'package:ecommerce_mobile_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:provider/provider.dart';
import '../widgets/product_items.dart';
import '../models/products_model.dart';
import '../providers/products_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _offerImages = [
    'assets/images/categories/suvi.jpg',
    'assets/images/categories/suvi.jpg',
    'assets/images/categories/suvi.jpg',
    'assets/images/categories/suvi.jpg'
  ];

  @override
  void initState() {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    productsProvider.fetchProducts();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    Size size = utils.getScreenSize;

    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productProviders.getProducts;

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      SizedBox(
        height: size.height * 0.33,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Image.asset(
              _offerImages[index],
              fit: BoxFit.fill,
            );
          },
          autoplay: true,
          itemCount: _offerImages.length,
          pagination: const SwiperPagination(
              alignment: Alignment.bottomCenter,
              builder: DotSwiperPaginationBuilder(
                  color: Colors.white, activeColor: Colors.red)),
        ),
      ),

      TextWidget(
        text: 'Our products',
        color: Colors.white,
        textSize: 22,
        isTitle: true,
      ),
      // const Spacer(),
      TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AppRoutes.routes['ProductsScreen']!(context),
            ),
          );
        },
        child: TextWidget(
          text: 'Browse all',
          maxLines: 1,
          color: Colors.blue,
          textSize: 20,
        ),
      ),
      GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: size.width / (size.height * 0.59),
        children: List.generate(
            allProducts.length < 4
                ? allProducts.length // length 3
                : 4, (index) {
          return ChangeNotifierProvider.value(
            value: allProducts[index],
            child: const ProductsWidget(),
          );
        }),
      )
    ])));
  }
}
