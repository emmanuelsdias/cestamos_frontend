import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CestamosBar extends StatelessWidget with PreferredSizeWidget {
  const CestamosBar({
    Key? key,
    this.actions = const <Widget>[],
  }) : super(key: key);

  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SvgPicture.asset(
        'assets/images/cestamos_logo_white.svg',
        fit: BoxFit.contain,
        height: 28,
      ),
      actions: actions,
      // elevation: 0.0,
      automaticallyImplyLeading: false,
      // actions: <Widget>[
      //   IconButton(
      //     icon: Icon(Icons.notifications),
      //     onPressed: () => null,
      //   ),
      //   IconButton(
      //     icon: Icon(Icons.person),
      //     onPressed: () => null,
      //   ),
      // ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
