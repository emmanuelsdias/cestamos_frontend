import 'package:flutter/material.dart';
import '../helpers/http-requests/shop_list.dart';
import '../widgets/shop_list_tile.dart';
import '../models/shop_list.dart';
import '../widgets/cestamos_bar.dart';
import './one_list_page.dart';
import './create_list_page.dart';
import '../widgets/add_floating_button.dart';

class ListsPage extends StatefulWidget {
  const ListsPage({super.key});
  static const pageRouteName = "/lists";

  @override
  State<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  List<ShopListSummary> _lists = [];

  Future<bool> _refreshList() async {
    var response = ShopListHttpRequestHelper.getLists();
    return response.then((value) {
      _lists = value.content;

      return value.success;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CestamosBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _refreshList();
              });
            },
            icon: const Icon(Icons.loop),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<bool>(
        future: _refreshList(),
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
                "Algo de errado aconteceu. Tente novamente mais tarde",
              ),
            );
          }
          return _lists.isEmpty
              ? const Center(
                  child: Text(
                    "Você não tem listas",
                  ),
                )
              : Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Minhas Listas",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              OneListPage.pageRouteName,
                              arguments: _lists[index],
                            ),
                            child: ShopListTile(
                              shopListSummary: _lists[index],
                            ),
                          );
                        },
                        itemCount: _lists.length,
                      ),
                    ),
                  ],
                );
        },
      ),
      floatingActionButton: AddFloatingButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(CreateListPage.pageRouteName),
      ),
    );
  }
}
