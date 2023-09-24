import 'package:ecommerce/main.dart';
import 'package:ecommerce/utils.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _form = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  label: Text('Email'),
                ),
                validator: Utils.emptyValidator,
              ),
              const SizedBox(height: 18),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text('Senha'),
                ),
                validator: Utils.emptyValidator,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: const Text("Entrar"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onPressed() async {
    if (!_form.currentState!.validate()) return;
    String userIdentifier = emailController.text;
    await Factory.init(userIdentifier: userIdentifier);
    if (mounted) Navigator.pushReplacementNamed(context, '/root', arguments: userIdentifier);
  }
}
