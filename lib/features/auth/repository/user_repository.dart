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
    TODO: //Register the user then signIn and return token
    return Future.delayed(const Duration(seconds: 1), () => email + password);
  }

  Future<void> forgotPassword({
    required String email,
  }) async {}
}
