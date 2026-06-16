// lib/features/auth/presentation/pages/register_page.dart

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/auth_service.dart';
import 'otp_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controller — text fieldlardan qiymat olish uchun
  late  TextEditingController _emailController ;
  late TextEditingController _passwordController ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  // AuthService instance
  final _authService = AuthService();

  // Loading holati
  bool _isLoading = false;

  // ─── REGISTER FUNKSIYA ──────────────────────────────
  // register_page.dart — _register funksiyasini o'zgar

  Future<void> _register() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showMessage('Email va parolni kiriting');
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.register(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // OTP sahifasiga o'tamiz, email'ni uzatamiz
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OtpPage(
            email: _emailController.text.trim(),
          ),
        ),
      );

    } on AuthException catch (e) {
      _showMessage(e.message);
      print(e.message);
    } catch (e) {
      _showMessage('Xatolik: ${e.toString()}');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // ─── SNACKBAR ───────────────────────────────────────
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    // Memory leak oldini olish — controllerlarni tozala
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ro\'yxatdan o\'tish')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Email field
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Password field
            TextField(
              controller: _passwordController,
              obscureText: true,       // parolni yashiradi
              decoration: const InputDecoration(
                labelText: 'Parol',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            // Register tugmasi
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _register,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Ro\'yxatdan o\'tish'),
              ),
            ),

            // Login sahifasiga o'tish
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Akkaunt bor? Kirish'),
            ),
          ],
        ),
      ),
    );
  }
}