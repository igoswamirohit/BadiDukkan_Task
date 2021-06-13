import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:task/repositories/authentication_repository/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent,
    AuthenticationState> {

  AuthenticationBloc(this._authenticationRepository)
      : super(AuthenticationInitial()){
    _userSubscription =
        _authenticationRepository
            .user
            .listen((user) => add(AuthenticationUserChanged(user)));
  }

  final AuthenticationRepository _authenticationRepository;
  StreamSubscription<User?>? _userSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if(event is AuthenticateUserRequested){
      try{
        yield (AuthenticationInProgress());
        _authenticationRepository.signInUsingPhone(event.context,event.phone);
      }catch(e) {
        yield (AuthenticationFailure());
      }
    }else if(event is ValidateOtpRequested){
      try{
        yield (OtpValidationInProgress());
        final credential =
        await _authenticationRepository.validateOtp(event.code);
        yield (AuthenticationSuccess(credential));
      }catch(e) {
        yield (AuthenticationFailure());
      }
    }else if(event is AuthenticationUserChanged){
      yield _mapAuthenticationUserChangedToState(event);
    }
  }
}

AuthenticationState _mapAuthenticationUserChangedToState(
    AuthenticationUserChanged event,
    ) {
  return event.user != null
      ? AuthenticationSuccess(event.user)
      : AuthenticationFailure();
}
