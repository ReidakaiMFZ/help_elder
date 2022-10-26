import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(auth.currentUser);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Help Elder'),
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: const [
            Text('Tela principal'),
            Image(
                image: NetworkImage(
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'))
          ],
        ),
        backgroundColor: const Color.fromARGB(225, 235, 249, 255),
      ),
    );
  }
}
