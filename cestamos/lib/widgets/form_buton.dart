import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    required this.text,
    required this.icon,
    required this.onPressed,
    this.option = 1,
    Key? key,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final Function onPressed;
  final int option;

  Color backgroundColor(BuildContext ctx) {
    switch (option) {
      case 1:
        {
          return Theme.of(ctx).colorScheme.inversePrimary;
        }
      default:
        {
          return Theme.of(ctx).colorScheme.background;
        }
    }
  }

  Color textColor(BuildContext ctx) {
    switch (option) {
      case 1:
        {
          return Colors.white;
        }
      default:
        {
          return Colors.black;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(0, 56),
        maximumSize: const Size(200, 100),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        shadowColor: Colors.transparent,
        primary: backgroundColor(context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              color: textColor(context),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Icon(
            icon,
            color: textColor(context),
          ),
        ],
      ),
    );
  }
}
