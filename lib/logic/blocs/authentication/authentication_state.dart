part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationSuccess extends AuthenticationState {
  const AuthenticationSuccess(this.data);

  final dynamic data;
  @override
  List<Object> get props => [];
}

class AuthenticationFailure extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationInProgress extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class OtpValidationInProgress extends AuthenticationState {
  @override
  List<Object> get props => [];
}
