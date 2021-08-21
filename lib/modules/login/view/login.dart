import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20), minimumSize: Size(115, 35) );

    final ButtonStyle loginStyle =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20), minimumSize: Size(115, 35) );

    return Scaffold(
        appBar: AppBar(
          title: Text('Login Screen App'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Hulp',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w700,
                          fontSize: 100),
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
                  padding: const EdgeInsets.fromLTRB(15.0,42.0,15,15),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    OutlinedButton(
                      onPressed: () {
                      print('Received click');
                      },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text('Cadastrar'),
                        ),style: style,),
                      ElevatedButton(
                                  style: style,
                                  onPressed: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: const Text('Login'),
                                  ),
                                ),
                    ],),
                ),
                OutlinedButton(
                  onPressed: () {
                    print('Received click');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text('LOGIN COM GOOGLE'),
                  ),),
                OutlinedButton(
                  onPressed: () {
                    print('Received click');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text('LOGIN COM FACEBOOK',style: TextStyle(color: Colors.white),),
                  ),style: OutlinedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(24, 119, 242,100)
                ),),
                OutlinedButton(
                  onPressed: () {
                    print('Received click');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text('LOGIN COM APPLE',style: TextStyle(color: Colors.white),),
                  ),style: OutlinedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(51, 51, 51,100)
                ),),
                TextButton(
                  onPressed: () {
                    print('Received click');
                  },
                  child: const Text('Esqueci a senha')),

              ],
            )));
  }
}