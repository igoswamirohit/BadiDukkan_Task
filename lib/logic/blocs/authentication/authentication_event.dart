part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}
class AuthenticateUserRequested extends AuthenticationEvent{

  const AuthenticateUserRequested(this.context,this.phone);

  final String phone;
  final BuildContext context;
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ValidateOtpRequested extends AuthenticationEvent{
  const ValidateOtpRequested(this.code);

  final String code;
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserAuthenticationSucceed extends AuthenticationEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LogoutUserRequested extends AuthenticationEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthenticationUserChanged extends AuthenticationEvent {
  const AuthenticationUserChanged(this.user);

  final User? user;

  @override
  List<Object?> get props => [user];
}
