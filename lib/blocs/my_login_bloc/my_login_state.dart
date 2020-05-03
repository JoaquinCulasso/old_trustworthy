part of 'my_login_bloc.dart';

abstract class MyLoginState extends Equatable {
  const MyLoginState();
}

//Estado Inicial
class MyLoginInitial extends MyLoginState {
  @override
  List<Object> get props => [];
}

//Ejecutando la operación de login y que la app se actualiza en consecuencia del evento
class LogginInState extends MyLoginState {
  @override
  List<Object> get props => null;
}

//Estado conectado con exito, nos devuelve un token para comparar con el servidor
class LoggedInState extends MyLoginState {
  final String token;

  LoggedInState(this.token);

  @override
  List<Object> get props => [token];
}

//Si ocurre algún error, si lanza mensaje al usuario de login fallido
class ErrorState extends MyLoginState {
  final String message;

  ErrorState(this.message);
  @override
  List<Object> get props => [message];
}
