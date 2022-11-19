import 'package:flutter/material.dart';

class ElevatedGradientButton extends StatelessWidget {
  const ElevatedGradientButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.color1,
      required this.color2,
      required this.textColor,
      required this.iconChosen});
  final Function onPressed;
  final String text;
  final Color color1;
  final Color color2;
  final Color textColor;
  final IconData iconChosen;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color1,
                color2,
              ],
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 20,
                ),
                Icon(
                  iconChosen,
                  color: textColor,
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          onPressed();
        },
      ),
    );
  }
}
