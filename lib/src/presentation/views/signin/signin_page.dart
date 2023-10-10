import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shample_app/src/config/themes/colors_map.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.only(left: 13, bottom: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Olá!',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Bem vindo(a) ao Shample!',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 38, top: 40, right: 38, bottom: 10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      const TextField(
                        decoration: InputDecoration(
                          hintText: 'EMAIL',
                        ),
                      ),
                      const SizedBox(height: 10),
                      const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'SENHA',
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 70,
                        child: Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              context.go('/homepage');
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ColorsMap.secondary,
                                minimumSize: const Size(double.infinity, 70),
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            child: const Text('ACESSAR'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text('NOVA CONTA'),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('ESQUECI A SENHA'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
