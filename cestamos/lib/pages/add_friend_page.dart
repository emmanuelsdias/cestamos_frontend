import 'package:cestamos/pages/logged_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/cestamos_bar.dart';

class AddFriendPage extends StatefulWidget {
  const AddFriendPage({super.key});
  static const pageRouteName = "/addfriend";

  @override
  State<AddFriendPage> createState() => _AddFriendPage();
}

class _AddFriendPage extends State<AddFriendPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CestamosBar(),
      body: AddFriendForm(),
    );
  }
}

// Create a Form widget.
class AddFriendForm extends StatefulWidget {
  const AddFriendForm({super.key});

  @override
  State<AddFriendForm> createState() => _AddFriendFormState();
}

// Create a corresponding State class.
// This class holds data related to the form.
class _AddFriendFormState extends State<AddFriendForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'User ID',
              labelText: 'Friend\'s User ID *',
            ),
            onSaved: (String? value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
              // ---------------
              // PESSOAL DO BACK REQUEST AQUI !!!!!
              // ----------------------
            },
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Digite o User ID';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.mail),
              hintText: 'Email',
              labelText: 'Friend\'s Email *',
            ),
            onSaved: (String? value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
              // ---------------
              // PESSOAL DO BACK REQUEST AQUI !!!!!
              // ----------------------
            },
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Digite o email';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  // ---------------
                  // PESSOAL DO BACK REQUEST AQUI !!!!!
                  // ----------------------
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Enviando Convite')),
                  );
                }
              },
              child: const Text('Enviar Convite'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () => {(Navigator.of(context).pop())},
              child: const Text('Cancelar'),
            ),
          ),
        ],
      ),
    );
  }
}
