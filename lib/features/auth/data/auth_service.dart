import 'package:learm_supabase/features/auth/presentantion/pages/forgot_password_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  Future<AuthResponse> register({
    required String email,
    required String password,
  }) async {
    return await supabase.auth.signUp(password: password, email: email);
  }

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    return await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
  }

  Future<AuthResponse> verifyOtp({
    required String email,
    required String otp,
  }) async {
    return await supabase.auth.verifyOTP(type: OtpType.email,email: email,token: otp);
  }

  Future<void> resendOtp({required String email}) async {
    await supabase.auth.resend(
      type: OtpType.email,
      email: email,
    );
  }

  User? get currentUser => supabase.auth.currentUser;

  bool get isLoggedIn => supabase.auth.currentUser != null;
}
