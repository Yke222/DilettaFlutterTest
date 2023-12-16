import 'package:diletta_flutter_test/blocs/sign_in_bloc.dart';
import 'package:diletta_flutter_test/repository/firebase_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool sigInRequired = false;
  String? _errorMsg;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: BlocProvider<SignInBloc>(
            create: (final context) =>
                SignInBloc(userRepository: GetIt.I<FirebaseRepository>()),
            child: BlocBuilder<SignInBloc, SignInState>(
              builder: (final BuildContext context, final SignInState state) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'email',
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                      TextField(
                        controller: passwordController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'password',
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      !sigInRequired
                          ? SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.pressed)) {
                                        return Colors.orange;
                                      }
                                      return Colors
                                          .orange; // Use the component's default.
                                    },
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<SignInBloc>().add(
                                        SignInRequiredEvent(
                                            emailController.text,
                                            passwordController.text));
                                    if (state is SigInSuccess) {
                                      context.go('/home');
                                    }
                                  }
                                },
                                child: const Text('Sign in'),
                              ),
                            )
                          : const CircularProgressIndicator(),
                    ]);
              },
            )));
  }
}
