import 'package:flutter/material.dart';
import 'package:hulp/modules/interactor/auth.dart';
import 'package:hulp/modules/interactor/storage.dart';


class EventPresenter {
  AuthenticatorInteractor auth = new AuthenticatorInteractor();
  LocalStorage _storage =  new LocalStorage();

  Future listEvent(email, password) async {
    return await auth.login(email, password).then((value) => _storage.saveToken(value));
  }




}
