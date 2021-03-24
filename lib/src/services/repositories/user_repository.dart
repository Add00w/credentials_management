class UserRepository {
  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    return Future.delayed(
      const Duration(seconds: 1),
      () => email + password,
    );
  }

  Future<String> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    TODO: //Register the user then signin and return token
    return Future.delayed(const Duration(seconds: 1), () => email + password);
  }

  Future<void> forgotPassword({
    required String email,
  }) async {}
}
