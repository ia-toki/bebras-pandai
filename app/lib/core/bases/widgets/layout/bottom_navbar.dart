import 'dart:ui';

// import 'package:artefak/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:artefak/widgets/auth_sliding_panel.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  final int currentIndex;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0; // To track the selected menu item
  void _onTap(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.popUntil(context, ModalRoute.withName('/'));
        break;
      case 1:
        Navigator.pushNamed(context, '/collection');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);

    // Update the selected menu item index and rebuild the widget
    void _updateIndex(int newIndex) {
      setState(() {
        _currentIndex = newIndex;
      });
    }

    // Custom method to build IconButton with color change based on selection
    Widget _buildIconButton(IconData icon, String label, int index) {
      return SizedBox.fromSize(
        size: Size(80, 56),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FaIcon(
                  icon,
                  color: _currentIndex == index ? Colors.blue : Colors.grey,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11.0,
                    color: _currentIndex == index ? Colors.blue : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      // return IconButton(
      //   icon: FaIcon(
      //     icon,
      //     color: _currentIndex == index ? Colors.blue : Colors.grey,
      //   ),
      //   onPressed: () {
      //     _updateIndex(index);
      //   },
      // );
    }

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 30.0,
          sigmaY: 30.0,
        ),
        child: SizedBox(
          height: 60,
          child: BottomAppBar(
            elevation: 2,
            // items: <BottomNavigationBarItem>[
            shape: const CircularNotchedRectangle(),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildIconButton(FontAwesomeIcons.fileLines, "Materi", 0),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 9.0,
                  ),
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Latihan",
                    style: TextStyle(fontSize: 11.0),
                  ),
                ),
                _buildIconButton(FontAwesomeIcons.gear, "Pengaturan", 1),
                // IconButton(
                //   onPressed: () {
                //     _updateIndex(0);
                //   },
                //   icon: const FaIcon(FontAwesomeIcons.fileLines),
                // ),
                // IconButton(
                //   onPressed: () {
                //     _updateIndex(1);
                //   },
                //   icon: const FaIcon(FontAwesomeIcons.gear),
                // ),
              ],
            ),
            // currentIndex: currentIndex,
            // onTap: (index) => _onTap(index, context),
          ),
        ),
      ),
    );
  }
}
