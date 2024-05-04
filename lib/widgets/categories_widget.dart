import 'package:ecommerce_mobile_app/routes/app_routes.dart';
import 'package:ecommerce_mobile_app/screens/screens.dart';
import 'package:ecommerce_mobile_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget(
      {Key? key,
      required this.catText,
      required this.imgPath,
      required this.passedColor})
      : super(key: key);
  final String catText, imgPath;
  final Color passedColor;
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context).size.width;
    Color color = Colors.white;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategorieScreen(
              catText: catText,
            ),
          ),
        );
      },
      child: Container(
        // height: _screenWidth * 0.6,
        decoration: BoxDecoration(
          color: passedColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: passedColor.withOpacity(0.7),
            width: 2,
          ),
        ),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          // Container for the image
          Container(
            height: screenWidth * 0.3,
            width: screenWidth * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    imgPath,
                  ),
                  fit: BoxFit.fill),
            ),
          ),
          // Category name
          TextWidget(
            text: catText,
            color: color,
            textSize: 20,
            isTitle: true,
          ),
        ]),
      ),
    );
  }
}
