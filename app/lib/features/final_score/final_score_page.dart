import 'package:flutter/material.dart';

import '../../core/bases/widgets/layout/bebras_scaffold.dart';
import '../../core/constants/assets.dart';

class FinalScorePage extends StatefulWidget {
  const FinalScorePage({super.key});

  @override
  State<FinalScorePage> createState() => _FinalScorePageState();
}

class _FinalScorePageState extends State<FinalScorePage> {
  @override
  Widget build(BuildContext context) {
    return BebrasScaffold(
        body: SingleChildScrollView(
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                Assets.bebrasPandaiText,
              ),
              const SizedBox(
                height: 40,
              ),
              const Text('LATIHAN SELESAI'),
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                Assets.logo,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration:
                    BoxDecoration(border: Border.all(), color: Colors.grey),
                child: Column(
                  children: [
                    Text('Total Nilai: 20'),
                    Text('benar: 3, salah: 10'),
                    Text('MANTAP!!!')
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Sampai jumpa di Latihan Bebras selanjutnya'),
            ],
          ),
        ),
      ]),
    ));
  }
}
