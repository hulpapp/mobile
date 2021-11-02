import 'package:flutter/material.dart';
import 'package:hulp/modules/interactor/auth.dart';
import 'package:hulp/modules/interactor/storage.dart';


class UserPresenter {
  AuthenticatorInteractor auth = new AuthenticatorInteractor();
  LocalStorage _storage =  new LocalStorage();

  Future loginWithEmail(email, password) async {
    return await auth.login(email, password).then((value) => _storage.saveToken(value));
  }




}
