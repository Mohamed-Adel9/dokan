
abstract class Exceptions {
  String message ;
  Exceptions(this.message);
}

class NetworkException extends Exceptions {
  NetworkException(super.message);
}
class ServerException extends Exceptions {
  ServerException(super.message);
}
class AuthException extends Exceptions {
  AuthException(super.message);
}
class FirebaseAuthException extends Exceptions{
  FirebaseAuthException(super.message);

}