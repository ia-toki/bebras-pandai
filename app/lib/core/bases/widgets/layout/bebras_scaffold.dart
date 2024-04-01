import 'package:flutter/material.dart';

class BebrasScaffold extends StatelessWidget {
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButton? floatingActionButton;
  final Widget body;
  final Widget? bottomNavigationBar;
  final bool avoidBottomInset;
  const BebrasScaffold({
    required this.body,
    super.key,
    this.avoidBottomInset = true,
    this.bottomNavigationBar,
    this.floatingActionButtonLocation,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: avoidBottomInset,
      body: SafeArea(
        child: body,
      ),
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
