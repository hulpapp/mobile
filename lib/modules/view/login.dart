import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hulp/utils/responsivity.dart';
import 'package:hulp/modules/presenter/user.dart';

class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  UserPresenter userControl = new UserPresenter();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool isLoading = true;

  void _changed() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future login() async {
    userControl.loginWithEmail(
        _emailController.text, _passwordController.text).then((value) =>
        Navigator.pushNamed(
          context,
          '/home/',
        )).catchError((error) => {
    alertDialog(context, error as String),
        _changed(),
    _passwordController.clear()
  });
  }

  alertDialog(BuildContext context, String errorMessage) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: const Text('Erro'),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20), minimumSize: Size(115, 35));

    final ButtonStyle loginStyle = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
        minimumSize: Size(115, 35),
        primary: Color.fromRGBO(98, 0, 238, 1));

    return Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
              padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
              child: Center(
                child: Container(
                  width: card(context),
                  child: ListView(
                    children: <Widget>[
                      Center(
                        child: Text('hulp',
                            style: GoogleFonts.anton(
                                fontSize: 100,
                                fontWeight: FontWeight.w700,
                                color: Color.fromARGB(255, 72, 20, 69))),
                      ),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                        validator: (email) {
                          if (email == null || email.isEmpty) {
                            return 'Por favor, digite seu e-mail';
                          } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(_emailController.text)) {
                            return 'Por favor, digite um e-mail correto';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Senha',
                        ),
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return 'Por favor, digite sua senha';
                          }
                          return null;
                        },
                      ),
                      isLoading
                          ? Padding(
                        padding: const EdgeInsets.fromLTRB(10, 42.0, 10, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/signup/',
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: const Text('CADASTRAR'),
                              ),
                              style: style,
                            ),
                            ElevatedButton(
                              style: loginStyle,
                              onPressed: () async {
                                FocusScopeNode currentFocus = FocusScope.of(
                                    context);
                                if (_formKey.currentState!.validate()) {
                                  _changed();
                                  if (currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  await login();
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: const Text('LOGIN'),
                              ),
                            ),
                          ],
                        ),
                      )
                          : Padding(
                        padding: const EdgeInsets.fromLTRB(10, 42.0, 10, 10),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Visibility(
                        child: TextButton(
                            onPressed: () {
                              print('Received click');
                            },
                            child: Text('Esqueci a senha',
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(102, 102, 102, 1)))),
                        visible: isLoading,
                      ),
                    ],
                  ),
                ),
              )),
        ));
  }
}