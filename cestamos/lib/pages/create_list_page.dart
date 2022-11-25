import 'package:cestamos/models/friendship.dart';
import 'package:flutter/material.dart';

import '../widgets/cestamos_bar.dart';

class CreateListPage extends StatefulWidget {
  const CreateListPage({Key? key}) : super(key: key);

  static const pageRouteName = "/create_list";

  @override
  State<CreateListPage> createState() => _CreateListPageState();
}

class _CreateListPageState extends State<CreateListPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _friends = <Friendship>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CestamosBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Criar nova lista",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  hintText: "Nome da lista",
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                validator: (String? userName) {
                  if (userName == null || userName.isEmpty) {
                    return "Dê um nome à sua lista!";
                  }
                  return null;
                },
                keyboardType: TextInputType.name,
                onSaved: (userName) {
                  if (userName != null) {
                    // _user.userName = userName;
                  }
                },
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.vpn_key),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  hintText: "senha",
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                obscureText: true,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Preencha a senha!";
                  }
                  return null;
                },
                onSaved: (password) {
                  if (password != null) {
                    // _user.password = password;
                  }
                },
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (value) {
                  // _saveForm();
                },
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(0, 56),
                    maximumSize: const Size(200, 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    shadowColor: Colors.transparent,
                    primary: Theme.of(context).colorScheme.inversePrimary),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Criar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.add,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
