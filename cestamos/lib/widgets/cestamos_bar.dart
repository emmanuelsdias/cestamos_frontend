import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CestamosBar extends AppBar {
  CestamosBar({super.key})
      : super(
          title: SvgPicture.asset(
            '../assets/images/cestamos_logo_white.svg',
            fit: BoxFit.contain,
            height: 28,
          ),
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


// AppBar(
//       title: SvgPicture.asset(
//         '../assets/images/cestamos_logo_white.svg',
//         fit: BoxFit.contain,
//         height: 28,
//       ),
//       automaticallyImplyLeading: false,
//     );