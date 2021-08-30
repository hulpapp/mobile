import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hulp/modules/view/singUp/signUp.dart';
import 'package:hulp/utils/responsivity.dart';


class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20), minimumSize: Size(115, 35) );

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
                        controller: nameController,
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10,42.0,10,10),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SingUpPage()),
                            );

                          },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: const Text('CADASTRAR'),
                            ),style: style,),
                          ElevatedButton(
                                      style: loginStyle,
                                      onPressed: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: const Text('LOGIN'),
                                      ),
                                    ),
                        ],),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                        onPressed: () {
                          print('Received click');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: const Text('LOGIN COM GOOGLE'),
                        ),),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                        onPressed: () {
                          print('Received click');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: const Text('LOGIN COM FACEBOOK',style: TextStyle(color: Colors.white),),
                        ),style: OutlinedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255,24,119,242)
                      ),),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                        onPressed: () {
                          print('Received click');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: const Text('LOGIN COM APPLE',style: TextStyle(color: Colors.white),),
                        ),style: OutlinedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(51, 51, 51,1)
                      ),),
                    ),
                    SizedBox(height: 15,),
                    TextButton(
                      onPressed: () {
                        print('Received click');
                      },
                      child: Text(
                          'Esqueci a senha',
                          style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w400, color: Color.fromRGBO(102, 102, 102, 1))
                      )),

                  ],
                ),
              ),
            )));
  }
}