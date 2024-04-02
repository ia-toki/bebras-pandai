import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    required this.currentIndex, super.key,
  });

  final int currentIndex;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  void _onTap(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/main');
        break;
      case 1:
        context.go('/setting');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {

    // Custom method to build IconButton with color change based on selection
    Widget buildIconButton(IconData icon, String label, int index) {
      return SizedBox.fromSize(
        size: const Size(80, 56),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              _onTap(index, context);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FaIcon(
                  icon,
                  color: widget.currentIndex == index
                      ? const Color(0xFF1BB8E1) : const Color(0xFF666666),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: widget.currentIndex == index
                        ? const Color(0xFF1BB8E1) : const Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 30,
          sigmaY: 30,
        ),
        child: SizedBox(
          height: 60,
          child: BottomAppBar(
            elevation: 2,
            shape: const CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildIconButton(FontAwesomeIcons.fileLines, 'Materi', 0),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 9,
                  ),
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Latihan',
                    style: TextStyle(
                      fontSize: 11,
                      color: widget.currentIndex == 2
                          ? const Color(0xFF1BB8E1) : const Color(0xFF666666),
                    ),
                  ),
                ),
                buildIconButton(FontAwesomeIcons.gear, 'Pengaturan', 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
