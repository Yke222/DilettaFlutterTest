import 'package:diletta_flutter_test/blocs/sign_up_bloc.dart';
import 'package:diletta_flutter_test/component/input_text_field.dart';
import 'package:diletta_flutter_test/core/input_field_use_case.dart';
import 'package:diletta_flutter_test/models/user_model.dart';
import 'package:diletta_flutter_test/repository/firebase_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscurePassword = true;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool signUpRequired = false;
  String? _errorMsg;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: BlocProvider<SignUpBloc>(
            create: (final context) =>
                SignUpBloc(userRepository: GetIt.I<FirebaseRepository>()),
            child: BlocListener<SignUpBloc, SignUpState>(
                listener: (context, state) {
              if (state is SignUpSuccessState) {
                setState(() {
                  signUpRequired = false;
                });
              }
              if (state is SignUpProcessState) {
                setState(() {
                  signUpRequired = true;
                });
              }
              if (state is SignUpFailureState) {
                setState(() {
                  signUpRequired = false;
                  _errorMsg = 'Email ou senha inválidos!';
                });
              }
            }, child: BlocBuilder<SignUpBloc, SignUpState>(
                    builder: (final context, final state) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InputTextField(
                      controller: nameController,
                      hintText: 'nome',
                      inputType: TextInputType.name,
                      errorMsg: _errorMsg,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Preencha o campo nome!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InputTextField(
                      controller: emailController,
                      hintText: 'email',
                      inputType: TextInputType.emailAddress,
                      errorMsg: _errorMsg,
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
                          } else if (passwordRexExp.hasMatch(value)) {
                            return 'Digite uma senha valida!';
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
                    !signUpRequired
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
                                  UserModel user = UserModel.emptyUser();
                                  user = user.copyWith(
                                    name: nameController.text,
                                    email: emailController.text,
                                  );
                                  context.read<SignUpBloc>().add(
                                      SignUpRequiredEvent(
                                          user: user,
                                          password: passwordController.text));
                                }
                              },
                              child: const Text('Cadastrar'),
                            ),
                          )
                        : const Center(
                          child:
                              CircularProgressIndicator(color: Colors.orange)),
                  ]);
            }))));
  }
}
