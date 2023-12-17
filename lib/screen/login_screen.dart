import 'package:diletta_flutter_test/screen/sign_in_screen.dart';
import 'package:diletta_flutter_test/screen/sign_up_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.black,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              const Text(
                'Olá, faça o login para acessar o app!',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange),
              ),
              const SizedBox(
                height: kToolbarHeight,
              ),
              TabBar(
                  controller: tabController,
                  labelColor: Colors.orange,
                  tabs: const [
                    Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Entrar',
                          style: TextStyle(fontSize: 18),
                        )),
                    Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Cadastrar',
                          style: TextStyle(fontSize: 18),
                        )),
                  ]),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    SignInScreen(),
                    SignUpScreen(),
                  ],
                ),
              )
            ]),
          ),
        ));
  }
}
