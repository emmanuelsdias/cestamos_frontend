import 'package:flutter/material.dart';

import './form_buton.dart';

class ConfirmQuitShopListDialog extends StatelessWidget {
  const ConfirmQuitShopListDialog({
    required this.quit,
    Key? key,
  }) : super(key: key);

  final Function quit;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        // width: MediaQuery.of(context).size.width * 0.7,
        width: 200,
        height: 300,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Tem certeza que quer sair da lista?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              FormButton(
                text: "Não",
                icon: Icons.cancel,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                option: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              FormButton(
                text: "Sim",
                icon: Icons.exit_to_app_outlined,
                onPressed: quit,
              )
            ],
          ),
        ),
      ),
    );
  }
}
