import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:hulp/modules/view/singUp/upload.dart';
import 'package:hulp/utils/responsivity.dart';
import 'package:hulp/modules/view/singUp/adress.dart';
import 'package:hulp/modules/view/singUp/infoPessoal.dart';
import 'package:hulp/modules/view/singUp/login.dart';

class SingUpPage extends StatefulWidget {
  String get title => 'Cadastro';

  @override
  _SingUpPageState createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  var currentStep = 0;

  @override
  Widget build(BuildContext context) {

    var mapData = HashMap<String, String>();
    mapData["nome"] = InfoPessoalState.controllerName.text;
    mapData["cpf"] = InfoPessoalState.controllerCPF.text;
    mapData["rg"] = InfoPessoalState.controllerRG.text;
    mapData["birth"] = InfoPessoalState.controllerDateOfBirth.text;
    mapData["phone"] = InfoPessoalState.controllerMobileNo.text;
    mapData["email"] = LoginState.controllerEmail.text;
    mapData["cep"] = AdressState.controllerCEP.text;
    mapData["street"] = AdressState.controllerStreet.text;
    mapData["city"] = AdressState.controllerCity.text;
    mapData["state"] = AdressState.controllerState.text;

    List<Step> steps = [
      Step(
        title: Text('Informações Pessoais'),
        content: InfoPessoal(),
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

                if(step == 3  && InfoPessoalState.pessoalFormKey.currentState!.validate() &&
                    AdressState.adressFormKey.currentState!.validate() &&
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
                  if (currentStep == 0 && InfoPessoalState.pessoalFormKey.currentState!.validate()) {
                    currentStep = currentStep + 1;
                  } else if (currentStep == 1 &&
                      AdressState.adressFormKey.currentState!.validate()) {
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
