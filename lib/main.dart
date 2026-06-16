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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth App',
      // App ochilganda qaysi sahifa ko'rinsin?
      home: _getStartPage(),
    );
  }

  // User login bo'lganmi? Shunga qarab sahifa tanlash
  Widget _getStartPage() {
    final session = Supabase.instance.client.auth.currentSession;
    return session != null ? HomePage() : const LoginPage();
  }
}