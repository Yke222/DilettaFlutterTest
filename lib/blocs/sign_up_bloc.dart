import 'package:diletta_flutter_test/models/user_model.dart';
import 'package:diletta_flutter_test/repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;
  SignUpBloc({required final UserRepository userRepository})
      : _userRepository = userRepository,
        super(SignUpInitialState()) {
    on<SignUpRequiredEvent>((event, emit) async {
      emit(SignUpProcessState());
      try {
        await _userRepository.sigUp(event.user, event.password);
        emit(SignUpSuccessState());
      } catch (e) {
        emit(SignUpFailureState());
      }
    });
  }
}

// Events regions
abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class SignUpRequiredEvent extends SignUpEvent {
  final UserModel user;
  final String password;
  const SignUpRequiredEvent({required this.user, required this.password});
}
//

// States region
abstract class SignUpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpInitialState extends SignUpState {}

class SignUpSuccessState extends SignUpState {}

class SignUpFailureState extends SignUpState {
  final String? message;

  SignUpFailureState({this.message});
}

class SignUpProcessState extends SignUpState {}
//
