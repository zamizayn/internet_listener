import 'package:flutter/material.dart';
import 'package:internet_connection_listener/internet_connection_listener.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigatorService.navigatorKey, // Set global navigator key
      home: ConnectionListener(
        child: Scaffold(
          appBar: AppBar(title: const Text('Connection Listener Example')),
          body: const Center(
            child: Text('Toggle your internet to test listener'),
          ),
        ),
      ),
    );
  }
}
