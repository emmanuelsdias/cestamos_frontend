import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import '../helpers/http-requests/user.dart';
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
//   final User _user = User(email: "", password: "", userName: "");
//   var _successOnRegister = true;

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
                                const SizedBox(
                                  height: 10,
                                ),
                                Form(
                                  key: _formKey,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      //           if (_errorOnCreate)
                                      // const Text(
                                      //     "Ops... algo deu errado! Tente novamente por favor!"),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(Icons.person),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(25.0),
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
                                          if (userName == null || userName.isEmpty) {
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
                                              // _verifyUserName(userName);
                                            },
                                          )
                                        },
                                        keyboardType: TextInputType.name,
                                        onSaved: (userName) {
                                          if (userName != null) {
                                            // user.userName = userName;
                                          }
                                        },
                                        textInputAction: TextInputAction.next,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
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
                                          hintText: "endereço de email",
                                          filled: true,
                                          fillColor: Colors.grey[100],
                                        ),
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty || !value.contains("@")) {
                                            return "Digite um e-mail válido";
                                          }
                                          // if (!_emailIsValid) {
                                          //   return "Esse e-mail já está cadastrado!";
                                          // }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            // _verifyEmailAddress(value);
                                          });
                                        },
                                        keyboardType: TextInputType.emailAddress,
                                        onSaved: (email) {
                                          if (email != null) {
                                            // user.email = email;
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
                                          hintText: "escolha uma senha",
                                          filled: true,
                                          fillColor: Colors.grey[100],
                                        ),
                                        obscureText: true,
                                        validator: (String? value) {
                                          if (value == null || value.length < 6) {
                                            return "A senha deve ter pelo menos 6 caracteres";
                                          }
                                          return null;
                                        },
                                        onSaved: (password) {
                                          if (password != null) {
                                            //user.password = password;
                                          }
                                        },
                                        textInputAction: TextInputAction.next,
                                        onChanged: (value) {
                                          setState(() {
                                            //user.password = value;
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
                                            borderRadius: BorderRadius.circular(25.0),
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
                                          // if (value != user.password) {
                                          //   return "As senhas não coincidem";
                                          // }
                                          if (value == null || value.length < 6) {
                                            return "A senha deve ter pelo menos 6 caracteres";
                                          }
                                          return null;
                                        },
                                        textInputAction: TextInputAction.done,
                                        onFieldSubmitted: (value) {
                                          //_saveForm();
                                        },
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      // ElevatedGradientButton(
                                      //   text: 'entrar',
                                      //   onPressed: () {},
                                      //   textColor: Colors.white,
                                      //   iconChosen: Icons.Register,
                                      //   color1: Theme.of(context).colorScheme.inversePrimary,
                                      //   color2: Theme.of(context).colorScheme.inversePrimary,
                                      // ),
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
                                              'cadastrar',
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
                                              Icons.person_add,
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
                                            'Já possui conta?',
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {},
                                            style: TextButton.styleFrom(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 3,
                                              ),
                                            ),
                                            child: Text(
                                              'Fazer login',
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
