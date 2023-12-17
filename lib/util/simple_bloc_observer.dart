import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange -- bloc: ${bloc.runtimeType}');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
        log('onClose -- bloc: ${bloc.runtimeType}');

  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
        log('onCreate -- bloc: ${bloc.runtimeType}');

  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
        log('onError -- bloc: ${bloc.runtimeType}');

  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
        log('onEvent -- bloc: ${bloc.runtimeType}');

  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
        log('onTransition -- bloc: ${bloc.runtimeType}');

  }
}
