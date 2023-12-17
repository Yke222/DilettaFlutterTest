import 'package:diletta_flutter_test/repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository _userRepository;
  SignInBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(SigInInitial()) {
    on<SignInRequiredEvent>((event, emit) async {
      emit(SigInProcess());
      try {
        await _userRepository.sigIn(event.email, event.password);
        emit(SigInSuccess());
      } catch (e) {
        emit(SigInFailure());
      }
    });
    on<SignOutRequiredEvent>((event, emit) async {
      await _userRepository.logOut();
    });
  }
}

// Events regions
abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object?> get props => [];
}

class SignInRequiredEvent extends SignInEvent {
  final String email;
  final String password;

  const SignInRequiredEvent(this.email, this.password);
}

class SignOutRequiredEvent extends SignInEvent {
  const SignOutRequiredEvent();
}
//

// States region
abstract class SignInState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SigInInitial extends SignInState {}

class SigInSuccess extends SignInState {}

class SigInProgress extends SignInState {}

class SigInFailure extends SignInState {
  final String? message;

  SigInFailure({this.message});
}

class SigInProcess extends SignInState {}
//
