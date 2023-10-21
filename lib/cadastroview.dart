import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'userrepository.dart';
import 'User.dart';

class CadastroView extends StatefulWidget {
  const CadastroView({super.key});

  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {
  DateTime? selectedDate;

  UserRepository userRepository = UserRepository();
  final controllerName = TextEditingController();

  final controllerAge = TextEditingController();

  final controllerDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(32),
        children: <Widget>[
          TextField(
            controller: controllerName,
            decoration: decoration(label: 'name'),
          ),
          const SizedBox(
            height: 24,
          ),
          TextField(
            controller: controllerAge,
            decoration: decoration(label: 'age'),
          ),
          const SizedBox(
            height: 24,
          ),
          DateTimeField(
            decoration: const InputDecoration(
              labelText: 'Select Date and Time',
            ),
            selectedDate: selectedDate,
            onDateSelected: (DateTime date) {
              setState(() {
                selectedDate = date;
                controllerDate.text = date.toLocal().toString();
              });
            },
          ),
          const SizedBox(
            height: 32,
          ),
          ElevatedButton(
              onPressed: () {
                final user = User(
                  name: controllerName.text,
                  age: int.parse(controllerAge.text),
                  birthday: selectedDate,
                );
                userRepository.createUser(user);
                Navigator.of(context).pop();
              },
              child: const Text('Enviar')),
        ],
      ),
    );
  }
}

InputDecoration decoration({required String label}) {
  return InputDecoration(
    labelText: label, // Um rótulo para o campo
    hintText: 'Enter your name', // Dica para o usuário
  );
}
