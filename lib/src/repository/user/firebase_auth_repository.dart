abstract class ThirdPartyAuthRepository {
  Future<void> signInWithGoogle();

  Future<void> signOutFromGoogle();
}
