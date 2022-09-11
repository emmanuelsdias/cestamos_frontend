import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'register_page.dart';
import 'logged_screen.dart';

// import '../helpers/http-requests/user.dart';
// import '../models/user.dart';
// import '../widgets/elevated_gradient_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const pageRouteName = "/login";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final User _user = User(email: "", password: "", userName: "");
//   var _successOnLogin = true;

  @override
  Widget build(BuildContext context) {
    // if (!_usersAreLoaded) {
    //   _loadUsers();
    // }
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFF2E71B3),
                  Color(0xFF22486D),
                ],
              ),
            ),
          ),
          Positioned(
            left: -MediaQuery.of(context).size.width * 0.1,
            top: MediaQuery.of(context).size.height * 0.5,
            child: SvgPicture.asset(
              '../assets/images/cestamos_C_white.svg',
              alignment: Alignment.center,
              // width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.8,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    '../assets/images/cestamos_icon_white.svg',
                    fit: BoxFit.contain,
                    width: 120,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "bem-vindo!",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(
                                  height: 10,
                                ),
                                Form(
                                  key: _formKey,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
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
                                          hintText: "usuário / email",
                                          filled: true,
                                          fillColor: Colors.grey[100],
                                        ),
                                        validator: (String? userName) {
                                          if (userName == null || userName.isEmpty) {
                                            return "Preencha seu nome de usuário!";
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
                                      // ElevatedGradientButton(
                                      //   text: 'entrar',
                                      //   onPressed: () {},
                                      //   textColor: Colors.white,
                                      //   iconChosen: Icons.login,
                                      //   color1: Theme.of(context).colorScheme.inversePrimary,
                                      //   color2: Theme.of(context).colorScheme.inversePrimary,
                                      // ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pushReplacementNamed(LoggedScreen.pageRouteName);
                                        },
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
                                              'entrar',
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
                                              Icons.login,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Não possui conta?',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pushReplacementNamed(RegisterPage.pageRouteName);
                                            },
                                            style: TextButton.styleFrom(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 3,
                                              ),
                                            ),
                                            child: Text(
                                              'Cadastre-se',
                                              style: TextStyle(
                                                color: Theme.of(context).colorScheme.inversePrimary,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
