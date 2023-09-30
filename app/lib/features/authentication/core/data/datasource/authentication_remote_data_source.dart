part of '_datasource.dart';

abstract class AuthenticationRemoteDataSource {
  Future<User> signIn();
}

@Injectable(as: AuthenticationRemoteDataSource)
class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instanceFor(
    app: FirebaseService.app,
  );

  @override
  Future<User> signIn() async {
    final googleSignInAccount = await _googleSignIn.signIn();
    if (googleSignInAccount == null) {
      throw Exception('SignIn cancelled');
    }

    final auth = await googleSignInAccount.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );

    final result = await _firebaseAuth.signInWithCredential(credential);
    return result.user!;
  }
}
