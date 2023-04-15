import 'package:flutter/material.dart';
import '../widgets/cestamos_bar.dart';
// import '../helpers/http-requests/user.dart';
// import '../models/user.dart';

class RecipeDetailPage extends StatefulWidget {
  const RecipeDetailPage({Key? key}) : super(key: key);
  static const pageRouteName = "/recipe_detail";

  @override
  // ignore: library_private_types_in_public_api
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CestamosBar(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Receita única aqui!',
            ),
          ],
        ),
      ),
    );
  }
}
