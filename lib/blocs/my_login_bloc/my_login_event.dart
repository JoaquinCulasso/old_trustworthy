part of 'my_login_bloc.dart';

abstract class MyLoginEvent extends Equatable {
  const MyLoginEvent();
}

//Cuando se hace login se reciben un email y contraseña para iniciar sesión
class DoLoginEvent extends MyLoginEvent {
  final String email;
  final String password;

  DoLoginEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
