class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class AuthSuccessState extends AuthStates {}

class AuthFailureState extends AuthStates {
  final String error;

  AuthFailureState({required this.error});
}

class UpdateLoadingState extends AuthStates {}

class UpdateSucessState extends AuthStates {}

class UpdateErrorState extends AuthStates {
  final String error;

  UpdateErrorState({required this.error});
}
