import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final void Function()? press;
  final IconData? icon;
  final Color? backGround;
  const DefaultButton(
      {super.key, required this.text, this.press, this.backGround, this.icon});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        width: 300,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: backGround,
        ),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(backgroundColor: backGround),
          label: Text(text.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 19,
              )),
          onPressed: press,
          icon: Icon(icon),
        ),
      ),
    );
  }
}
