import 'package:flutter/material.dart';
import '../helpers/http-requests/shop_list.dart';
// import '../models/user.dart';
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
  Future<List<ShopListSummary>> _refreshList() async {
    // refresh
    var lists = ShopListHttpRequestHelper.getLists();
    return lists.then(
      (value) {
        print(value.content.length);
        return value.content;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CestamosBar(
        actions: [
          IconButton(
            onPressed: _refreshList,
            icon: const Icon(Icons.loop),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<List<ShopListSummary>>(
        future: _refreshList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var lists = snapshot.data!;
          return lists.isEmpty
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
                            onTap: () => Navigator.of(context)
                                .pushNamed(OneListPage.pageRouteName),
                            child: ShopListTile(
                              shopListSummary: lists[index],
                            ),
                          );
                        },
                        itemCount: lists.length,
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
