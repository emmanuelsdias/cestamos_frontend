import 'package:flutter/material.dart';

class AddFloatingButton extends StatelessWidget {
  const AddFloatingButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => onPressed(),
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
