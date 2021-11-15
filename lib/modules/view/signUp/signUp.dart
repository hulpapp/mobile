import 'package:flutter/material.dart';
import 'package:hulp/modules/entities/signUp.dart';
import 'package:hulp/modules/view/signUp/upload.dart';
import 'package:hulp/utils/responsivity.dart';
import 'package:hulp/modules/view/signUp/address.dart';
import 'package:hulp/modules/view/signUp/personalInfo.dart';
import 'package:hulp/modules/view/signUp/login.dart';
import 'package:hulp/modules/presenter/user.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SignUpPage extends StatefulWidget {
  String get title => 'Cadastro';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var currentStep = 0;
  bool logging = false;

  UserPresenter userPresenter = new UserPresenter();

  @override
  Widget build(BuildContext context) {


    SignUp mapData =new SignUp();
    mapData.name = PersonalInfoState.controllerName.text;
    mapData.cpf = PersonalInfoState.controllerCPF.text;
    mapData.identity  = PersonalInfoState.controllerPassport.text;
    mapData.telephone  = PersonalInfoState.controllerMobileNo.text;
    mapData.email = LoginState.controllerEmail.text;
    mapData.cep = AddressState.controllerCEP.text;
    mapData.street = AddressState.controllerStreet.text;
    mapData.city = AddressState.controllerCity.text;
    mapData.state  = AddressState.controllerState.text;
    mapData.password = LoginState.controllerPassword.text;
    mapData.passwordConfirmation = LoginState.controllerPassword.text;

    List<Step> steps = [
      Step(
        title: Text('Pessoais'),
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
      body:  Center(
        child: !logging? Container(
          width: card(context),
          child: Stepper(
            currentStep: this.currentStep,
            steps: steps,
            type: StepperType.horizontal,
            onStepTapped: (step) {
              setState(() {
                print(step);

                if(step == 3  && PersonalInfoState.personalFormKey.currentState.validate() &&
                    AddressState.addressFormKey.currentState.validate() &&
                    LoginState.loginFormKey.currentState.validate() ){
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
                  if (currentStep == 0 && PersonalInfoState.personalFormKey.currentState.validate()) {
                    currentStep = currentStep + 1;
                  } else if (currentStep == 1 &&
                      AddressState.addressFormKey.currentState.validate()) {
                    currentStep = currentStep + 1;
                  }
                  else if (currentStep == 2 &&
                      LoginState.loginFormKey.currentState.validate()) {
                    currentStep = currentStep + 1;

                  }
                } else {
                  userPresenter.createNewUser(mapData).then((value)=>{
                    Alert(
                  context: context,
                  type: AlertType.success,
                  title: "Usuário Criado com sucesso!!",
                  desc: "Gentileza realizar o login",
                  buttons: [
                  DialogButton(
                  child: Text(
                  "OK",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () =>      Navigator.pushNamed(
                    context,
                    '/login/',
                  ),
                  width: 120,
                  )
                  ],
                  ).show()}
                  );

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
        ): CircularProgressIndicator(),
      ),
    );
  }
}
