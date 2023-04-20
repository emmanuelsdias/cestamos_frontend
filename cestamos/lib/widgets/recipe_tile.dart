import 'package:flutter/material.dart';
import '../models/recipe.dart';
import './helpers/flight_shuttle_builder.dart';

class RecipeTile extends StatelessWidget {
  const RecipeTile({Key? key, required this.recipeSummary}) : super(key: key);
  final RecipeSummary recipeSummary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: ListTile(
          title: Hero(
              transitionOnUserGestures: true,
              tag: recipeSummary.id,
              flightShuttleBuilder: flightShuttleBuilder,
              child: Column(
                children: [
                  Text(
                    recipeSummary.recipeName,
                    overflow: TextOverflow.clip,
                    softWrap: false,
                  ),
                  Text(
                    recipeSummary.description,
                    overflow: TextOverflow.clip,
                    softWrap: false,
                  ),
                  Text(
                    'Tempo de preparo: ${recipeSummary.prepTime} min',
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
