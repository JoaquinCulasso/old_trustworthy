// import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:old_trustworthy/states/login_state.dart';

part 'my_login_event.dart';
part 'my_login_state.dart';

class MyLoginBloc extends Bloc<MyLoginEvent, MyLoginState> {
  final LoginState login; // clase que maneja el estado de login

  MyLoginBloc({@required this.login});

  @override
  MyLoginState get initialState => MyLoginInitial();

  @override
  Stream<MyLoginState> mapEventToState(
    MyLoginEvent event,
  ) async* {
    if (event is DoLoginEvent) {
      yield* _doLogin(event);
    }
  }

  Stream<MyLoginState> _doLogin(DoLoginEvent event) async* {
    yield LogginInState();

    //hacer el login
    try {
      var token = await login.login(event.email, event.password);
      yield LoggedInState(token);
    } on LoginException {
      //falla el login
      yield ErrorState("No se puedo loguear");
    }
  }
}
