import 'package:diletta_flutter_test/presentation/blocs/sign_in_bloc.dart';
import 'package:diletta_flutter_test/presentation/component/input_text_field.dart';
import 'package:diletta_flutter_test/domain/core/input_field_use_case.dart';
import 'package:diletta_flutter_test/data/repository/firebase_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscurePassword = true;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool sigInRequired = false;
  String? _errorMsg;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocProvider<SignInBloc>(
        create: (final context) =>
            SignInBloc(userRepository: GetIt.I<FirebaseRepository>()),
        child: BlocListener<SignInBloc, SignInState>(
          listener: (context, state) {
            if (state is SigInSuccess) {
              setState(() {
                sigInRequired = false;
              });
            }
            if (state is SigInProgress) {
              setState(() {
                sigInRequired = true;
              });
            }
            if (state is SigInFailure) {
              setState(() {
                sigInRequired = false;
                _errorMsg = 'Email ou senha inválidos!';
              });
            }
          },
          child: BlocBuilder<SignInBloc, SignInState>(
            builder: (final context, final state) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InputTextField(
                      controller: emailController,
                      hintText: 'email',
                      inputType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Preencha o campo de email!';
                        } else if (!emailRexExp.hasMatch(value)) {
                          return 'Preencha um email valido!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InputTextField(
                        controller: passwordController,
                        obscureText: obscurePassword,
                        hintText: 'senha',
                        inputType: TextInputType.emailAddress,
                        errorMsg: _errorMsg,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Preencha o campo de senha';
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            iconPassword,
                            color: Colors.orange,
                          ),
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                              if (obscurePassword) {
                                iconPassword = CupertinoIcons.eye_fill;
                              } else {
                                iconPassword = CupertinoIcons.eye_slash_fill;
                              }
                            });
                          },
                        )),
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
                                    return Colors.orange;
                                  },
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<SignInBloc>().add(
                                      SignInRequiredEvent(emailController.text,
                                          passwordController.text));
                                }
                              },
                              child: const Text('Entrar'),
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                                color: Colors.orange)),
                  ]);
            },
          ),
        ),
      ),
    );
  }
}
