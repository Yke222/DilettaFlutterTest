import 'package:diletta_flutter_test/data/repository/user_repository.dart';
import 'package:diletta_flutter_test/di/dependency_injection.dart';
import 'package:diletta_flutter_test/presentation/blocs/authentication_bloc_screen.dart';
import 'package:diletta_flutter_test/presentation/screen/login_screen.dart';
import 'package:diletta_flutter_test/presentation/screen/welcome_screen.dart';
import 'package:diletta_flutter_test/util/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repository/firebase_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await DependencyInjection().setup();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Bloc.observer = SimpleBlocObserver();

  runApp(MyApp(FirebaseRepository()));
}

Future<void> setup() async {
  DependencyInjection();
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  const MyApp(this.userRepository, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
            create: (_) => AuthenticationBloc(userRepo: userRepository)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: ((context, state) {
            if (state.status == AuthenticationStatus.unauthenticated) {
              return const LoginScreen();
            }
            return const WelcomeScreen();
          }),
        ),
      ),
    );
  }
}
