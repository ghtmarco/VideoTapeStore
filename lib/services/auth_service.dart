class AuthService {
  static bool loginAdmin(String username, String password) {
    return username == 'admin' && password == 'admin1';
  }
}
