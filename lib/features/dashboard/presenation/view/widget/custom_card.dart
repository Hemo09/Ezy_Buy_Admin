import 'package:ezy_buy_adminn/core/widgets/subtitle_text.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {super.key, required this.text, required this.image, this.press});
  final String text;
  final String image;
  final Function()? press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 56,
              width: 56,
            ),
            const SizedBox(
              height: 20,
            ),
            SubtitleTextWidget(
              label: text,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
