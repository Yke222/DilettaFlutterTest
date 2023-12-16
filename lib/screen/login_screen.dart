import 'package:diletta_flutter_test/component/login_component.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Icon(
                    Icons.store,
                    color: Colors.orange,
                    size: 160,
                  ),
                  LoginForm(),
                ]),
          ),
        ));
  }
}
