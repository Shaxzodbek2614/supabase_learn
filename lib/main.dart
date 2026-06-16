// lib/main.dart

import 'package:flutter/material.dart';
import 'package:learm_supabase/features/auth/presentantion/pages/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/auth/presentantion/pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://gxyerryhhdwmbjxuehod.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd4eWVycnloaGR3bWJqeHVlaG9kIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODEwODQzOTAsImV4cCI6MjA5NjY2MDM5MH0.6Aqj9vhsGOegCJUpD3slOvcPqK5z4SZyrGOafkx7w_8',
  );

  runApp(const MyApp());
}

// lib/main.dart — MyApp ni o'zgartiring

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth App',
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    // Stream — auth holati o'zgarganda avtomatik rebuild qiladi
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {

        // Stream hali yuklanmagan
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Auth holati
        final session = snapshot.data?.session;

        // Session bor → Home, yo'q → Login
        if (session != null) {
          return const HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}