abstract class Failures {
  final String massage ;

  const Failures(this.massage);
}

class ServerFailure extends Failures {
  ServerFailure(super.massage);
}

class NetworkFailure extends Failures {
  NetworkFailure(super.massage);
}

class AuthFailure extends Failures {
  AuthFailure(super.massage);
}