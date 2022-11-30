import 'package:flutter/material.dart';
import '../widgets/cestamos_bar.dart';
import '../widgets/form_buton.dart';

class AddFriendPage extends StatefulWidget {
  const AddFriendPage({super.key});
  static const pageRouteName = "/addfriend";

  @override
  State<AddFriendPage> createState() => _AddFriendPage();
}

class _AddFriendPage extends State<AddFriendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CestamosBar(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const AddFriendForm(),
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
  String _friendEmail = "";
  String _userID = "";

  void sendInvite() {
    // TO DO: implementar a request
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(
              Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
                spreadRadius: 1,
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Adicionar amigo",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                Expanded(
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email_rounded),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: "Email",
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                          obscureText: true,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Insira o email";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
                          onChanged: (friendEmail) {
                            if (friendEmail.isNotEmpty) {
                              _friendEmail = friendEmail;
                            }
                          },
                          textInputAction: TextInputAction.done,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.numbers_rounded),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: "User ID",
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                          obscureText: true,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Insira o user ID";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
                          onChanged: (userID) {
                            if (userID.isNotEmpty) {
                              _userID = userID;
                            }
                          },
                          textInputAction: TextInputAction.done,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FormButton(
                  text: "Adicionar",
                  icon: Icons.add,
                  onPressed: sendInvite,
                  option: 1,
                ),
                const SizedBox(
                  height: 20,
                ),
                FormButton(
                  text: "Cancelar",
                  icon: Icons.cancel,
                  onPressed: () => Navigator.of(context).pop(),
                  option: 2,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }
}
