import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hulp/modules/view/signUp/signUp.dart';
import 'package:hulp/utils/responsivity.dart';
import 'package:hulp/modules/presenter/user.dart';


class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading= true;

  void _changed() {
    setState(() {isLoading = !isLoading;
    });
  }


  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20), minimumSize: Size(115, 35) );
    UserPresenter userControl =  new UserPresenter(context);
    final ButtonStyle loginStyle =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20), minimumSize: Size(115, 35),primary: Color.fromRGBO(98, 0, 238, 1)  );

    return Scaffold(
        body: Padding(
            padding: EdgeInsets.fromLTRB(10,40,10,10),
            child: Center(
              child: Container(

                width: card(context),
                child: ListView(
                  children: <Widget>[
                    Container(

                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'hulp',
                          style: GoogleFonts.anton(fontSize: 100,fontWeight: FontWeight.w700, color: Color.fromARGB(255,72,20,69))
                        )),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Senha',
                        ),
                      ),
                    ),
                    isLoading? Padding(
                      padding: const EdgeInsets.fromLTRB(10,42.0,10,10),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              MaterialPageRoute(builder: (context) => SignUpPage()),
                              '/signup/',
                            );

                          },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: const Text('CADASTRAR'),
                            ),style: style,),
                          ElevatedButton(
                                      style: loginStyle,
                                      onPressed: () { _changed();
                                      userControl.loginWithEmail(emailController.text, passwordController.text);
                                        },
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: const Text('LOGIN'),
                                      ),
                                    ),
                        ],),
                    ) : Padding(
                      padding: const EdgeInsets.fromLTRB(10,42.0,10,10),
                      child: Center(child:CircularProgressIndicator()),
                    ),
                    SizedBox(height: 60,),
                    Visibility(
                      child: TextButton(
                        onPressed: () {
                          print('Received click');
                        },
                        child: Text(
                            'Esqueci a senha',
                            style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w400, color: Color.fromRGBO(102, 102, 102, 1))
                        )),
                      visible: isLoading,
                    ),

                  ],
                ),
              ),
            )));
  }
}