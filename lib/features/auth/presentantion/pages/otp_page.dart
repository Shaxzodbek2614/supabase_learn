// lib/features/auth/presentation/pages/otp_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_otp_kit/flutter_otp_kit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/auth_service.dart';
import 'home_page.dart';

class OtpPage extends StatelessWidget {
  final String email; // register'dan kelgan email

  const OtpPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return Scaffold(
      body: OtpKit(
        title: 'Emailni tasdiqlang',
        subtitle: 'Kodni shu emailga yubordik:\n$email',
        fieldCount: 6, // Supabase 6 raqamli kod yuboradi

        // ─── TASDIQLASH ───────────────────────────────
        onVerify: (otp) async {
          try {
            final response = await authService.verifyOtp(
              email: email,
              otp: otp, // foydalanuvchi kiritgan kod
            );

            if (response.user != null) {
              // Tasdiqlandi — Home sahifasiga o'tamiz
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
                    (route) => false,
              );
              return true; // OtpKit'ga: muvaffaqiyatli
            }
            return false;

          } on AuthException catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.message)),
            );
            return false; // OtpKit'ga: xato bo'ldi

          } catch (e) {
            return false;
          }
        },

        // ─── QAYTA YUBORISH ───────────────────────────
        onResend: () async {
          await authService.resendOtp(email: email);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Kod qayta yuborildi')),
          );
        },

        // ─── UI SOZLAMALARI ───────────────────────────
        primaryColor: Colors.blue,
        successColor: Colors.green,
        errorColor: Colors.red,
        animationConfig: OtpAnimationConfig(
          enableAnimation: true,
          errorFieldAnimationType: ErrorFieldAnimationType.bounce,
        ),
      ),
    );
  }
}