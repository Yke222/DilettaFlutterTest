import 'package:diletta_store/core/constants/error_constants.dart';
import 'package:diletta_store/core/errors/custom_error.dart';
import 'package:diletta_store/core/utils/check_internet_connection.dart';
import 'package:diletta_store/layers/domain/entities/user_entity.dart';
import 'package:diletta_store/layers/domain/usecases/auth_usecases/get_user_usecase.dart';
import 'package:diletta_store/layers/domain/usecases/auth_usecases/sign_in_usecase.dart';
import 'package:diletta_store/layers/domain/usecases/auth_usecases/sign_out_usecase.dart';
import 'package:diletta_store/layers/domain/usecases/auth_usecases/sign_up_usecase.dart';
import 'package:mobx/mobx.dart';

part 'auth_controller.g.dart';

class AuthController = _AuthController with _$AuthController;

abstract class _AuthController with Store {
  late final SignInUseCase _signInUseCase;
  late final SignUpUseCase _signUpUseCase;
  late final SignOutUseCase _signOutUseCase;
  late final GetUserUseCase _getUserUseCase;

  _AuthController({
    required SignInUseCase signInUseCase,
    required SignUpUseCase signUpUseCase,
    required SignOutUseCase signOutUseCase,
    required GetUserUseCase getUserUseCase,
  }) {
    _signInUseCase = signInUseCase;
    _signUpUseCase = signUpUseCase;
    _signOutUseCase = signOutUseCase;
    _getUserUseCase = getUserUseCase;
  }

  // Responsible for transmitting error messages to the UI;
  @observable
  String? errorMessage;

  // Tells the UI if the user is logged in;
  @observable
  bool isUserLoggedIn = false;

  /// Gets the current user and changes the application's internal state to
  /// logged in or logged out.
  @action
  UserEntity? getUser() {
    final user = _getUserUseCase();

    if (isUserLoggedIn && user == null) isUserLoggedIn = false;
    if (!isUserLoggedIn && user != null) isUserLoggedIn = true;

    return user;
  }

  /// Passes an error to the UI so that it is reported to the user.
  @action
  void setErrorMessage(String? message) {
    errorMessage = message;
  }

  /// After verification, it sends the data obtained from the user for a login
  /// attempt and informs the UI if there are errors during this process.
  Future<void> signIn(String email, String password) async {
    // Checks the user's internet connection;
    if (!await CheckInternetConnection()()) {
      return setErrorMessage(ErrorConstants.noInternet);
    }

    try {
      await _signInUseCase(email, password);
      getUser();
    } on CustomError catch (error) {
      setErrorMessage(error.message);
    } catch (_) {
      setErrorMessage(ErrorConstants.unknownError);
    }
  }

  /// After verification, it sends the data obtained from the user for a sign up
  /// attempt and informs the UI if there are errors during this process.
  Future<void> signUp(String email, String password) async {
    // Checks the user's internet connection;
    if (!await CheckInternetConnection()()) {
      return setErrorMessage(ErrorConstants.noInternet);
    }

    try {
      await _signUpUseCase(email, password);
      getUser();
    } on CustomError catch (error) {
      setErrorMessage(error.message);
    } catch (_) {
      setErrorMessage(ErrorConstants.unknownError);
    }
  }

  /// Tries to log out of the logged in account and informs the UI if there are
  /// errors during this process.
  Future<void> signOut() async {
    try {
      await _signOutUseCase();
      getUser();
    } on CustomError catch (error) {
      setErrorMessage(error.message);
    } catch (_) {
      setErrorMessage(ErrorConstants.unknownError);
    }
  }
}
