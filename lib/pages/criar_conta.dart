import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange[800],
        title: const Text('Registro'),
      ),
      body: Container(
        padding: const EdgeInsets.all(45),
        //color: Colors.orange.shade700,
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            //color: Colors.white,
            border: Border.all(
              width: 1,
              color: Colors.grey.shade500,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                  height: 100, child: Image.asset('lib/images/dlivros.png')),
              TextFormField(
                controller: txtNome,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: txtEmail,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: txtSenha,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    FirebaseFirestore.instance.collection('/usuarios').add({
                      'nome': txtNome.text,
                      'email': txtEmail.text,
                    });
                    criarConta(txtNome.text, txtEmail.text, txtSenha.text);
                  },
                  child: const Text('registrar'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.orange.shade800,
                      textStyle: const TextStyle(
                        fontSize: 16,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(
                color: Colors.black26,
                height: 1,
              ),
              const SizedBox(
                height: 30,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: 'Já possui uma conta? ',
                    style: TextStyle(color: Colors.grey[500])),
                TextSpan(
                    text: 'Login',
                    style: const TextStyle(color: Colors.blueAccent),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pop(context);
                      })
              ]))
            ],
          ),
        ),
      ),
    );
  }

  void criarConta(nome, email, senha) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: senha)
        .then((value) {
      exibirmsg('Usuário criado com sucesso!');
      Navigator.pop(context);
    }).catchError((erro) {
      if (erro.code == 'email-already-in-use') {
        exibirmsg('ERRO: O email informado já está em uso!');
      } else {
        exibirmsg('ERRO: ${erro.message}');
      }
    });
  }

  void exibirmsg(msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
