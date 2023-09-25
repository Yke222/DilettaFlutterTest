import 'package:diletta_store/layers/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final AuthController _authController = GetIt.I.get<AuthController>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar Conta", textScaleFactor: 1),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(30.0),
          shrinkWrap: true,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 135,
                  width: 115,
                  child: Image.asset("assets/images/diletta_logo.png"),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "DILETTA",
                      textScaleFactor: 1,
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("SOLUTIONS", textScaleFactor: 1),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(150, 0, 0, .2),
                    blurRadius: 20.0,
                    offset: Offset(0, 10),
                  )
                ],
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade100),
                      ),
                    ),
                    child: TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email a ser cadastrado",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Senha",
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () async {
                FocusScope.of(context).unfocus();

                await _authController.signUp(
                  _emailController.text,
                  _passwordController.text,
                );

                if (_authController.isUserLoggedIn) {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(255, 0, 0, 1),
                      Color.fromRGBO(170, 0, 0, .7),
                    ],
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Cadastrar",
                    textScaleFactor: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
