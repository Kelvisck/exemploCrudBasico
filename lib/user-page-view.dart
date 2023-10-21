import 'package:crudbasico/cadastroview.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';

class UserPageView extends StatefulWidget {
  @override
  State<UserPageView> createState() => _UserPageViewState();
}

class _UserPageViewState extends State<UserPageView> {
  final controllerName = TextEditingController();

  final controllerAge = TextEditingController();

  final controllerDate = TextEditingController();

  final myHomePage = MyHomePage();

  final docUser = FirebaseFirestore.instance.collection('users').doc();
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: StreamBuilder<List<User>>(
          stream: myHomePage.readUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("Erro: ${snapshot.error}");
              return Text('Something went WRONG!');
            } else if (snapshot.hasData) {
              final users = snapshot.data!;
              print("Número de usuários: ${users.length}");

              return ListView(children: users.map(buildUser).toList());
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CadastroView()));
        },
        child: const Icon(Icons.add),
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

Widget buildUser(User user) => ListTile(
      leading: CircleAvatar(
          child: Text(
        '${user.age}',
      )),
      title: Text(user.name.toString()),
      subtitle: Text(user.birthday?.toIso8601String() ??
          'Data de nascimento nao encontrada nessa dsgrc'),
    );
