import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'register_page.dart';
import 'logged_screen.dart';

import '../helpers/http-requests/user.dart';
import '../widgets/form_buton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const pageRouteName = "/login";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _email = "";
  var _password = "";
  var _successOnLogin = true;

  void _logIn(BuildContext ctx) {
    _successOnLogin = true;
    if (!_formKey.currentState!.validate()) return;
    UserHttpRequestHelper.logInUser(
      _email,
      _password,
    ).then(
      (response) {
        setState(() {
          _successOnLogin = response.success;
          _formKey.currentState!.validate();
        });
        if (!_formKey.currentState!.validate() || !_successOnLogin) {
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

  Future<bool> checkIfLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    var logged = pref.getBool('loggedIn') ?? false;
    return logged;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkIfLoggedIn(),
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
          // Página de carregamento
        } else {
          if (snapshot.data!) {
            Future.microtask(() => Navigator.of(context)
                .pushReplacementNamed(LoggedScreen.pageRouteName));
          }
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
                                        autovalidateMode:
                                            AutovalidateMode.disabled,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            TextFormField(
                                              decoration: InputDecoration(
                                                prefixIcon: const Icon(
                                                    Icons.email_rounded),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
                                                  borderSide: const BorderSide(
                                                    width: 0,
                                                    style: BorderStyle.none,
                                                  ),
                                                ),
                                                hintText: "email",
                                                filled: true,
                                                fillColor: Colors.grey[100],
                                              ),
                                              validator: (String? email) {
                                                if (email == null ||
                                                    email.isEmpty) {
                                                  return "Preencha seu email!";
                                                }
                                                return null;
                                              },
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              onChanged: (email) {
                                                setState(() {
                                                  _email = email;
                                                });
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                prefixIcon:
                                                    const Icon(Icons.vpn_key),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
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
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Preencha a senha!";
                                                }
                                                if (!_successOnLogin) {
                                                  return "Senha ou login incorretos.";
                                                }
                                                return null;
                                              },
                                              onChanged: (password) {
                                                setState(() {
                                                  _password = password;
                                                });
                                              },
                                              textInputAction:
                                                  TextInputAction.done,
                                              onFieldSubmitted: (_) {},
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            FormButton(
                                              text: "entrar",
                                              icon: Icons.login,
                                              onPressed: () => _logIn(context),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  'Não possui conta?',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushReplacementNamed(
                                                            RegisterPage
                                                                .pageRouteName);
                                                  },
                                                  style: TextButton.styleFrom(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 3,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'Cadastre-se',
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
      }),
    );
  }
}
