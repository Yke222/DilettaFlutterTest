import 'dart:async';

import 'package:diletta_flutter_test/repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  late final StreamSubscription<User?> _subscription;

  AuthenticationBloc({required UserRepository userRepo})
      : userRepository = userRepo,
        super(const AuthenticationState.unknown()) {
    _subscription = userRepository.user.listen((authUser) {
      add(AuthenticationUserChangedEvent(authUser));
    });
    on<AuthenticationUserChangedEvent>((event, emit) {
        if (event.user != null) {
          emit(AuthenticationState.authenticated(event.user!));
        } else {
          emit(const AuthenticationState.unauthenticated());
        }
    });
  }
  @override
  Future<void> close (){
    _subscription.cancel();
    return super.close();
  }
}

// Events
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
  @override
  List<Object?> get props => [];
}

class AuthenticationUserChangedEvent extends AuthenticationEvent {
  final User? user;

  const AuthenticationUserChangedEvent(this.user);
  @override
  List<Object?> get props => [];
}

// States
enum AuthenticationStatus { authenticated, unauthenticated, unknown }

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final User? user;

  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user)
      : this._(
          status: AuthenticationStatus.authenticated,
          user: user,
        );

  const AuthenticationState.unauthenticated()
      : this._(
          status: AuthenticationStatus.unauthenticated,
        );
  @override
  List<Object?> get props => [status, user];
}
