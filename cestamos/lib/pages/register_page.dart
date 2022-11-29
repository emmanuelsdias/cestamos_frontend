import 'package:cestamos/widgets/form_buton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';
import 'logged_screen.dart';

import '../helpers/http-requests/user.dart';
// import '../models/user.dart';
// import '../widgets/elevated_gradient_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static const pageRouteName = "/register";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _email = "";
  var _userName = "";
  var _password = "";
  var _successOnLogin = true;
  var _errorMessage = "";

  void _signUp(BuildContext ctx) {
    _successOnLogin = true;
    if (!_formKey.currentState!.validate()) return;
    UserHttpRequestHelper.createUser(
      _userName,
      _email,
      _password,
    ).then(
      (response) {
        setState(() {
          _successOnLogin = response.success;
          _formKey.currentState!.validate();
        });
        if (!_formKey.currentState!.validate() || !_successOnLogin) {
          print(response.errorMessage);
          return;
        }
        var prefs = SharedPreferences.getInstance();
        prefs.then((prefsValue) {
          prefsValue.setInt('user_id', response.content.id!);
          prefsValue.setString('username', response.content.userName!);
          prefsValue.setString('email', response.content.email!);
          prefsValue.setString('token', response.content.token!);
          prefsValue.setBool('loggedIn', true);
        });
        Navigator.of(ctx).pushReplacementNamed(LoggedScreen.pageRouteName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
              'assets/images/cestamos_C_white.svg',
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
                    'assets/images/cestamos_icon_white.svg',
                    fit: BoxFit.contain,
                    width: 120,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "cadastrar",
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
                                if (!_successOnLogin)
                                  Text(
                                    "Cadastro inválido",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Form(
                                  key: _formKey,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      //           if (_errorOnCreate)
                                      // const Text(
                                      //     "Ops... algo deu errado! Tente novamente por favor!"),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(Icons.person),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            borderSide: const BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          hintText: "nome de usuário",
                                          filled: true,
                                          fillColor: Colors.grey[100],
                                        ),
                                        validator: (String? userName) {
                                          if (userName == null ||
                                              userName.isEmpty) {
                                            return "Nome de usuário não pode ser vazio";
                                          }
                                          // if (!_userNameIsValid) {
                                          //   return "Esse nome de usuário já existe";
                                          // }
                                          return null;
                                        },
                                        onChanged: (userName) => {
                                          setState(
                                            () {
                                              _userName = userName;
                                            },
                                          )
                                        },
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          prefixIcon:
                                              const Icon(Icons.email_rounded),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            borderSide: const BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          hintText: "endereço de email",
                                          filled: true,
                                          fillColor: Colors.grey[100],
                                        ),
                                        validator: (String? value) {
                                          if (value == null ||
                                              value.isEmpty ||
                                              !value.contains("@")) {
                                            return "Digite um e-mail válido";
                                          }
                                          // if (!_emailIsValid) {
                                          //   return "Esse e-mail já está cadastrado!";
                                          // }
                                          return null;
                                        },
                                        onChanged: (email) {
                                          setState(() {
                                            _email = email;
                                          });
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textInputAction: TextInputAction.next,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(Icons.vpn_key),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            borderSide: const BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          hintText: "escolha uma senha",
                                          filled: true,
                                          fillColor: Colors.grey[100],
                                        ),
                                        obscureText: true,
                                        validator: (String? value) {
                                          if (value == null ||
                                              value.length < 6) {
                                            return "A senha deve ter pelo menos 6 caracteres";
                                          }
                                          return null;
                                        },
                                        textInputAction: TextInputAction.next,
                                        onChanged: (password) {
                                          setState(() {
                                            _password = password;
                                          });
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(Icons.vpn_key),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            borderSide: const BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          hintText: "repita sua senha",
                                          filled: true,
                                          fillColor: Colors.grey[100],
                                        ),
                                        obscureText: true,
                                        validator: (String? value) {
                                          if (value == null ||
                                              value != _password) {
                                            return "As senhas estão diferentes.";
                                          }
                                          return null;
                                        },
                                        textInputAction: TextInputAction.done,
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      FormButton(
                                        text: "cadastrar",
                                        icon: Icons.person_add,
                                        onPressed: () => _signUp(context),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Já possui conta?',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                      LoginPage.pageRouteName);
                                            },
                                            style: TextButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 3,
                                              ),
                                            ),
                                            child: Text(
                                              'Fazer login',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .inversePrimary,
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
