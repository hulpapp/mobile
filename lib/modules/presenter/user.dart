
import 'package:flutter/cupertino.dart';
import 'package:hulp/modules/interactor/auth.dart';
import 'package:flutter/material.dart';



class UserPresenter {

 AuthenticatorInteractor auth = new AuthenticatorInteractor();
 BuildContext context;

 UserPresenter(this.context);

 void  loginWithEmail(email,password) async {
  var login =  await auth.login(email,password);
  // print(email);
  // alertDialog(this.context);



 }

 alertDialog(BuildContext context){
  showDialog<String>(
   context: context,
   builder: (BuildContext context) => AlertDialog(
    title: const Text('AlertDialog Title'),
    content: const Text('AlertDialog description'),
    actions: <Widget>[
     TextButton(
      onPressed: () => Navigator.pop(context, 'Cancel'),
      child: const Text('Cancel'),
     ),
     TextButton(
      onPressed: () => Navigator.pop(context, 'OK'),
      child: const Text('OK'),
     ),
    ],
   ),
  );
 }







}

