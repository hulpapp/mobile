import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:hulp/modules/view/signUp/upload.dart';
import 'package:hulp/utils/responsivity.dart';
import 'package:hulp/modules/view/signUp/address.dart';
import 'package:hulp/modules/view/signUp/personalInfo.dart';
import 'package:hulp/modules/view/signUp/login.dart';

class SignUpPage extends StatefulWidget {
  String get title => 'Cadastro';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var currentStep = 0;

  @override
  Widget build(BuildContext context) {

    var mapData = HashMap<String, String>();
    mapData["nome"] = PersonalInfoState.controllerName.text;
    mapData["cpf"] = PersonalInfoState.controllerCPF.text;
    mapData["rg"] = PersonalInfoState.controllerRG.text;
    mapData["birth"] = PersonalInfoState.controllerDateOfBirth.text;
    mapData["phone"] = PersonalInfoState.controllerMobileNo.text;
    mapData["email"] = LoginState.controllerEmail.text;
    mapData["cep"] = AddressState.controllerCEP.text;
    mapData["street"] = AddressState.controllerStreet.text;
    mapData["city"] = AddressState.controllerCity.text;
    mapData["state"] = AddressState.controllerState.text;

    List<Step> steps = [
      Step(
        title: Text('Informações Pessoais'),
        content: PersonalInfo(),
        state: currentStep == 0 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text('Endereço'),
        content: Contact(),
        state: currentStep == 1 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text('Login'),
        content: Login(),
        state: currentStep == 2 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text('Upload'),
        content: Upload(mapData),
        state: currentStep == 3 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          width: card(context),
          child: Stepper(
            currentStep: this.currentStep,
            steps: steps,
            type: StepperType.horizontal,
            onStepTapped: (step) {
              setState(() {
                print(step);

                if(step == 3  && PersonalInfoState.personalFormKey.currentState!.validate() &&
                    AddressState.addressFormKey.currentState!.validate() &&
                    LoginState.loginFormKey.currentState!.validate() ){
                  currentStep = step;
                }
                else{
                  currentStep = step;
                }

              });
            },
            onStepContinue: () {
              setState(() {
                if (currentStep < steps.length - 1) {
                  if (currentStep == 0 && PersonalInfoState.personalFormKey.currentState!.validate()) {
                    currentStep = currentStep + 1;
                  } else if (currentStep == 1 &&
                      AddressState.addressFormKey.currentState!.validate()) {
                    currentStep = currentStep + 1;
                  }
                  else if (currentStep == 2 &&
                      LoginState.loginFormKey.currentState!.validate()) {
                    currentStep = currentStep + 1;

                  }
                } else {
                  currentStep = 0;
                }
              });
            },
            onStepCancel: () {
              setState(() {
                if (currentStep > 0) {
                  currentStep = currentStep - 1;
                } else {
                  currentStep = 0;
                }
              });
            },
          ),
        ),
      ),
    );
  }
}
