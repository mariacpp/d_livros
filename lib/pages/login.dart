//LOGIN PAGE
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login'),
        backgroundColor: Colors.yellow.shade600,
      ),
      body: Container(
        padding: const EdgeInsets.all(45),
        //color: Colors.yellow.shade300,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            //color: Colors.white,
            border: Border.all(
              width: 1,
              color: Colors.grey.shade500,
            ),
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(height: 100, child: Image.asset('lib/images/dlivros.png')),
              TextFormField(
                controller: txtEmail,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  //focusColor: Colors.lightGreen[100],
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: txtSenha,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  focusColor: Colors.lightGreen[100],
                  border: const OutlineInputBorder(),
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
                    setState(() {
                      isLoading = true;
                    });
                    login(txtEmail.text, txtSenha.text);
                  },
                  child: const Text('entrar'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.yellow.shade800,
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
                    text: 'Não possui uma conta? ',
                    style: TextStyle(color: Colors.grey[500])),
                TextSpan(
                    text: 'Registrar-se',
                    style: const TextStyle(color: Colors.blueAccent),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, 'cadastro');
                      })
              ]))
            ],
          ),
        ),
      ),
    );
  }

  //
  // LOGIN com o Firebase Auth
  //
  void login(email, senha) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: senha)
        .then((value) {
      Navigator.pushReplacementNamed(context, 'generos');
    }).catchError((erro) {
      if (erro.code == 'user-not-found') {
        exibirmsg('ERRO: Usuário não encontrado.');
      } else if (erro.code == 'wrong-password') {
        exibirmsg('ERRO: Senha incorreta!');
      } else if (erro.code == 'invalid-email') {
        exibirmsg('ERRO: Email invalido.');
      } else {
        exibirmsg('ERRO: ${erro.message}');
      }
    });
  }

  void exibirmsg(msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: msg,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
