import 'package:flutter/material.dart';
// import '../helpers/http-requests/user.dart';
// import '../models/user.dart';
import '../widgets/shop_list_tile.dart';
import '../models/shop_list.dart';
import '../widgets/cestamos_bar.dart';
import './one_list_page.dart';
import './create_list_page.dart';

class ListsPage extends StatefulWidget {
  const ListsPage({super.key});
  static const pageRouteName = "/lists";

  @override
  State<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  final listassum = <ShopListSummary>[
    ShopListSummary(id: 1, shopListName: "Melhor grupo"),
    ShopListSummary(id: 2, shopListName: "Cestamos"),
    ShopListSummary(id: 3, shopListName: "CTC-34"),
    ShopListSummary(id: 4, shopListName: "Física de Plasmas"),
    ShopListSummary(id: 1, shopListName: "Melhor grupo"),
    ShopListSummary(id: 2, shopListName: "Cestamos"),
    ShopListSummary(id: 3, shopListName: "CTC-34"),
    ShopListSummary(id: 4, shopListName: "Física de Plasmas"),
    ShopListSummary(id: 1, shopListName: "Melhor grupo"),
    ShopListSummary(id: 2, shopListName: "Cestamos"),
    ShopListSummary(id: 3, shopListName: "CTC-34"),
    ShopListSummary(id: 4, shopListName: "Física de Plasmas"),
    ShopListSummary(id: 1, shopListName: "Melhor grupo"),
    ShopListSummary(id: 2, shopListName: "Cestamos"),
    ShopListSummary(id: 3, shopListName: "CTC-34"),
    ShopListSummary(id: 4, shopListName: "Física de Plasmas")
  ];

  void refreshList() {
    // refresh
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CestamosBar(
        actions: [
          IconButton(
            onPressed: refreshList,
            icon: const Icon(Icons.loop),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: listassum.isEmpty
          ? const Center(
              child: Text(
                "Você não tem listas",
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Suas Listas",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  );
                }
                return GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushNamed(OneListPage.pageRouteName),
                  child: ShopListTile(
                    shopListSummary: listassum[index - 1],
                  ),
                );
              },
              itemCount: listassum.length + 1,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(CreateListPage.pageRouteName),
        child: const Icon(Icons.add),
      ),
    );
  }
}
