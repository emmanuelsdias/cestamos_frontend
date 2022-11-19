import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CestamosBar extends StatelessWidget with PreferredSizeWidget {
  const CestamosBar({
    Key? key,
    this.title,
  }) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          SvgPicture.asset(
            'assets/images/cestamos_logo_white.svg',
            fit: BoxFit.contain,
            height: 28,
          ),
        ],
      ),
      //(title == null ? null : Text(title!))
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
