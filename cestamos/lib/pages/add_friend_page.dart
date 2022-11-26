import 'package:flutter/material.dart';
import '../widgets/cestamos_bar.dart';

class AddFriendPage extends StatefulWidget {
  const AddFriendPage({super.key});
  static const pageRouteName = "/addfriend";

  @override
  State<AddFriendPage> createState() => _AddFriendPage();
}

class _AddFriendPage extends State<AddFriendPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CestamosBar(),
    );
  }
}
