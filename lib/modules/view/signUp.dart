import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hulp/utils/responsivity.dart';
import 'package:intl/intl.dart';

class SingUpPage extends StatefulWidget {
  @override
  _SingUpPageState createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    double width = card(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            width: width,
            child: FormBuilder(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: ListView(
                children: [
                  Text(
                    'Informações pessoais',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  FormBuilderTextField(
                    name: 'name',
                    decoration: InputDecoration(labelText: 'Nome'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                  ),
                  const SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'email',
                    decoration: InputDecoration(labelText: 'E-mail'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.email(context),
                    ]),
                  ),
                  const SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'phone',
                    decoration: InputDecoration(labelText: 'Telefone'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.minLength(context, 6),
                    ]),
                  ),
                  const SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'cpf',
                    decoration: InputDecoration(labelText: 'CPF'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.minLength(context, 6),
                    ]),
                  ),
                  FormBuilderTextField(
                    name: 'userIds',
                    decoration: InputDecoration(labelText: 'Identidade'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.minLength(context, 6),
                    ]),
                  ),
                  FormBuilderDateTimePicker(
                    format: DateFormat("dd-MM-yyyy"),
                    name: 'birthDay',
                    inputType: InputType.date,
                    decoration:
                        InputDecoration(labelText: 'Data de Nascimento'),
                  ),
                  Row(
                    children: <Widget>[       Container(
                      child: FormBuilderTextField(

                        name: 'zipCode',
                        decoration: InputDecoration(labelText: 'CEP'),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.minLength(context, 6),
                        ]),
                      ),width: width* 0.60,
                    ),
                      Container(
                        child: FormBuilderTextField(
                          name: 'houseNumber',
                          decoration: InputDecoration(labelText: 'Numero'),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.minLength(context, 6),
                          ]),
                        ),width: width* 0.40
                      ),],
                  ),
                  FormBuilderTextField(
                    name: 'street',

                    decoration: InputDecoration(
                      labelText: 'Rua',


                    ),

                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[    Container(
                      child: FormBuilderTextField(
                        name: 'city',
                        decoration: InputDecoration(labelText: 'Cidade'),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.minLength(context, 6),
                        ]),
                      ),width: width* 0.60,
                    ),
                      Container(
                        child: FormBuilderTextField(
                          name: 'state',
                          decoration: InputDecoration(labelText: 'Estado'),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.minLength(context, 6),
                          ]),
                        ),width: width* 0.40,
                      ),],
                  ),
                  FormBuilderField<bool>(
                    name: 'test',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.equal(context, true),
                    ]),
                    // initialValue: true,
                    decoration: InputDecoration(labelText: 'Accept Terms?'),
                    builder: (FormFieldState<bool> field) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          errorText: field.errorText,
                        ),
                        child: SwitchListTile(
                          title: Text(
                              'Declaro que estou de acordo com os Termos de uso disponíveis aqui.'),
                          onChanged: (bool value) {
                            field.didChange(value);
                          },
                          value: field.value ?? false,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  MaterialButton(
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                        print('Valid');
                      } else {
                        print('Invalid');
                      }
                      print(_formKey.currentState?.value);
                    },
                    child:
                        Text('Signup', style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
