import 'package:dokan/core/errors/exceptions.dart';
import 'package:dokan/features/auth/data/dataSource/auth_remote_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dokan/features/auth/domain/entities/user.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthRemoteDataSource implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final FacebookAuth facebookAuth ;

  FirebaseAuthRemoteDataSource({
  required this.firebaseAuth,
  required this.googleSignIn,
  required this.facebookAuth
  });


  //login
  @override
  Future<UserEntity> login(String email, String password) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;

    if (user == null) {
      throw AuthException("User is null");
    }

    return UserEntity(
        id: user.uid,
        email: user.email ?? "",
      name: user.displayName ?? "noBody" ,

    );
  }

  @override
  Future<UserEntity> loginGoogle() async {
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      throw AuthException("User cancelled login");
    }

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await firebaseAuth.signInWithCredential(credential);
    final user = userCredential.user!;

    return UserEntity(
      id: user.uid.toString(),
      email: user.email ?? "",
      name: user.displayName ?? "noBody" ,

    );
  }

  @override
  Future<UserEntity> loginFacebook() async {
   try {
     final result = await facebookAuth.login(
       permissions: ['email', 'public_profile'],
     );
      if(result.status == LoginStatus.success){
        final userData = await facebookAuth.getUserData();
        return UserEntity(
            id: userData['id'],
            email: userData['email'],
            name: userData['name'],
        );
      }else if (result.status == LoginStatus.cancelled){
        throw AuthException("Login canceled by user");
      }else {
        throw AuthException("login failed");
      }
   } catch (e){
      throw AuthException(e.toString());
   }
  }


  //logout
  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }


  // signup
  @override
  Future<UserEntity> signUp(String name, String email, String password) async {
      try {
        final credential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        final user = credential.user;
        if (user == null) {
          throw AuthException("User Not Found");
        }
        return UserEntity(
          id: user.uid,
          email: user.email ?? "",
          name: user.displayName ?? name,
        );
      } catch (e) {
        throw AuthException(e.toString());
      }
    }

  @override
  Future<void> forgetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(
        email: email,
      );

    } catch (e) {
      throw AuthException(e.toString());
    }
  }


}
