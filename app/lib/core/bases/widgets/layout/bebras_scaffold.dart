import 'package:flutter/material.dart';

class BebrasScaffold extends StatelessWidget {
  final Widget body;
  final bool avoidBottomInset;
  const BebrasScaffold({required this.body, super.key, this.avoidBottomInset = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: avoidBottomInset,
      body: SafeArea(
        child: body,
      ),
    );
  }
}
