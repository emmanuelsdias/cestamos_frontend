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
      // ignore: avoid_unnecessary_containers
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.all(
            Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              spreadRadius: 1,
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(1, 1),
            ),
          ],
        ),
        margin: const EdgeInsets.all(10.0),
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
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(recipeSummary.description,
                      overflow: TextOverflow.clip,
                      softWrap: false,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                      )),
                  Row(
                    children: [
                      const Icon(
                        Icons.timer_rounded,
                        size: 30,
                        color: Color(0xFF25548D),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE9476D),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25),
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              spreadRadius: 1,
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.all(10.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Prep: ${recipeSummary.prepTime} min',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      const Icon(
                        Icons.timer_rounded,
                        size: 30,
                        color: Color(0xFF25548D),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE9476D),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25),
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              spreadRadius: 1,
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.all(10.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Cooking: ${recipeSummary.cookingTime} min',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      const Icon(
                        Icons.timer_rounded,
                        size: 30,
                        color: Color(0xFF25548D),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE9476D),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25),
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              spreadRadius: 1,
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.all(10.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Resting: ${recipeSummary.restingTime} min',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
