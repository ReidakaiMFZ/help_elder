import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore db = FirebaseFirestore.instance;

class CadastroFunc extends StatelessWidget {
  const CadastroFunc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passController = TextEditingController();
    final TextEditingController confirmPassController = TextEditingController();
    AlertDialog alert = AlertDialog(
      title: const Text("Erro"),
      content: const Text("Algum erro ocorreu"),
      actions: [
        TextButton(
          child: const Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );

    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: 500,
          height: 1000,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: 300,
                  child: Column(children: const [
                    Text(
                      'Cadastro',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text('Faça cadastro como cuidador de alguém'),
                    SizedBox(
                      height: 30,
                    ),
                  ])),
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                  ),
                  controller: emailController,
                ),
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                  ),
                  controller: passController,
                ),
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Confirmar Senha',
                  ),
                  controller: confirmPassController,
                ),
              ),
              SizedBox(
                width: 300,
                child: Row(
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (bool? value) {},
                      checkColor: const Color.fromARGB(255, 81, 241, 228),
                      activeColor: const Color.fromARGB(255, 81, 105, 241),
                    ),
                    const Text('Eu li e concordo com os Termos')
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 250,
                child: ElevatedButton(
                  style: (ElevatedButton.styleFrom(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      )),
                  child: const Text('Cadastrar'),
                  onPressed: () {
                    if (emailController.text.isNotEmpty &&
                        passController.text.isNotEmpty &&
                        passController.text == confirmPassController.text) {
                      auth
                          .createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passController.text)
                          .then((UserCredential user) => {
                                db
                                    .collection("funcionario")
                                    .doc(user.user!.uid)
                                    .set({"email": emailController.text})
                              });
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/home');
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Já tem cadastro? ',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: "Faça login",
                      style: const TextStyle(
                        color: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/login');
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(225, 235, 249, 255),
      ),
    );
  }
}