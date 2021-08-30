import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}



class LoginState extends State<Login> {
  bool _passwordVisible = false;
  static final loginFormKey = GlobalKey<FormState>();
  static TextEditingController controllerEmail = new TextEditingController();
  TextEditingController controllerConfirmEmail = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Form(
          autovalidateMode: AutovalidateMode.disabled,
          key: loginFormKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
                maxLines: 1,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.grey,
                  ),
                  labelText: 'E-mail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Email obrigatorio";
                  } return null;
                },
                controller: controllerEmail,
              ), //email
              SizedBox(height: 20),
              TextFormField(
                maxLines: 1,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.grey,
                  ),
                  labelText: 'Confirme o E-mail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Email obrigatorio";
                  } return null;
                },
                controller: controllerConfirmEmail,
              ), //email
              SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: controllerPassword,
            obscureText: !_passwordVisible,//This will obscure text dynamically
            decoration: InputDecoration(
              labelText: 'Senha',
              hintText: 'Crie sua senha',
              // Here is key idea
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),//confirmEmail
              SizedBox(height: 20),
            ],
          ),
        )
    );
  }

}