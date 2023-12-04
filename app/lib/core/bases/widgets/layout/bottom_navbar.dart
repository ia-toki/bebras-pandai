import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  // To track the selected menu item
  int _currentIndex = 0;
  void _onTap(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.popUntil(context, ModalRoute.withName('/main'));
        break;
      case 1:
        Navigator.pushNamed(context, '/setting');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Update the selected menu item index and rebuild the widget
    void _updateIndex(int newIndex) {
      setState(() {
        _currentIndex = newIndex;
      });
    }

    // Custom method to build IconButton with color change based on selection
    Widget _buildIconButton(IconData icon, String label, int index) {
      return SizedBox.fromSize(
        size: const Size(80, 56),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              _updateIndex(index);
              _onTap(index, context);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FaIcon(
                  icon,
                  color: _currentIndex == index ? const Color(0xFF1BB8E1) : Colors.grey,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: _currentIndex == index ? const Color(0xFF1BB8E1) : Colors.grey,
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
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildIconButton(FontAwesomeIcons.fileLines, 'Materi', 0),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 9,
                  ),
                  alignment: Alignment.bottomCenter,
                  child: const Text(
                    "Latihan",
                    style: TextStyle(fontSize: 11),
                  ),
                ),
                _buildIconButton(FontAwesomeIcons.gear, 'Pengaturan', 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
