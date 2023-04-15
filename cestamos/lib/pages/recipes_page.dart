import 'package:flutter/material.dart';
import '../widgets/cestamos_bar.dart';
import '../models/recipe.dart';
// import '../helpers/http-requests/user.dart';
// import '../models/user.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});
  static const pageRouteName = "/recipes";

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  List<RecipeSummary> _recipes = []; // TEM QUE CRIAR O MODEL DA RECEITA

  Future<bool> _refreshRecipes() async {
    // var response = ShopListHttpRequestHelper.getLists();
    // return response.then((value) {
    //   _lists = value.content;

    //   return value.success;
    // });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CestamosBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _refreshRecipes();
              });
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: const <Widget>[
      //       Text(
      //         'Minhas receitas aqui ficarão aqui!',
      //       ),
      //     ],
      //   ),
      // ),
      body: FutureBuilder<bool>(
          future: _refreshRecipes(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var success = snapshot.data!;
            if (!success) {
              return const Center(
                child: Text(
                    "Algo de errado aconteceu nas suas receitas. Tente novamente mais tarde!"),
              );
            }
            return _recipes.isEmpty
                ? const Center(
                    child: Text("Você ainda não tem receitas!"),
                  )
                : Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Minhas Receitas",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      )
                    ],
                  );
          }),
    );
  }
}
