import 'package:flutter/material.dart';

class BebrasScaffold extends StatelessWidget {
  final Widget body;
  const BebrasScaffold({required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: body,
      ),
    );
  }
}
