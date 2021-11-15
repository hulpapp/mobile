import 'package:flutter/material.dart';
import 'package:hulp/modules/entities/Bene.dart';
import 'package:hulp/modules/entities/Volunteer.dart';
import 'package:hulp/modules/interactor/auth.dart';
import 'package:hulp/modules/interactor/beneficiary.dart';
import 'package:hulp/modules/interactor/storage.dart';
import 'package:hulp/modules/interactor/volunteer.dart';
import 'package:hulp/modules/entities/signUp.dart';

class UserPresenter {
  AuthenticatorInteractor auth = new AuthenticatorInteractor();
  VolunteerInteractor volunteerInteractor = new VolunteerInteractor();
  BeneficiaryInteractor beneficiaryInteractor = new BeneficiaryInteractor();
  LocalStorage _storage =  new LocalStorage();

  Future loginWithEmail(email, password) async {
    return await auth.login(email, password).then((value) => _storage.saveToken(value));
  }

  Future<List<Volunteer>>  listVolunteer() async {
    final response = await volunteerInteractor.list();
    List<Volunteer> volunteers = [];

    for(final i in response){
      volunteers.add(Volunteer.fromJson(i));

    }
    return volunteers;
  }

  createNewUser(SignUp signup) async{
    return await auth.createUser(signup);
  }
  createNewBeneficiary(Beneficiary beneficiary) async{
    return await beneficiaryInteractor.create(beneficiary);
  }

  Future listBeneficiary() async {
    return await beneficiaryInteractor.list();
  }

}
