import 'package:flutter/material.dart';

class Item {
  String itemId;
  String name;
  String quantity;
  bool wasBought;

  Item({
    required this.itemId,
    required this.name,
    this.quantity = "",
    this.wasBought = false,
  });
}

class OneListPage extends StatefulWidget {
  const OneListPage({Key? key}) : super(key: key);
  static const pageRouteName = "/one_list";

  @override
  // ignore: library_private_types_in_public_api
  _OneListPageState createState() => _OneListPageState();
}

class _OneListPageState extends State<OneListPage> {
  List<Item> items = [
    Item(
      itemId: "1",
      name: "Arroz Tio João",
      quantity: "5 kg",
      wasBought: false,
    ),
    Item(
      itemId: "2",
      name: "Feijão Preto",
      quantity: "2 kg",
      wasBought: false,
    ),
    Item(
      itemId: "3",
      name: "Açúcar Refinado União",
      quantity: "300 g",
      wasBought: false,
    ),
    Item(
      itemId: "4",
      name: "Café Melissa",
      quantity: "1 caixa",
      wasBought: false,
    ),
  ];

  void refreshList() {
    // refresh
  }

  void removeItem(int index) {
    // remove item
    setState(() {
      items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Minha Lista"),
        actions: [
          IconButton(
            onPressed: refreshList,
            icon: const Icon(Icons.loop),
          ),
        ],
      ),
      body: ReorderableListView(
        onReorder: onReorder,
        buildDefaultDragHandles: false,
        children: _getListItems(),
      ),
    );
  }

  void onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    setState(() {
      Item item = items[oldIndex];

      items.removeAt(oldIndex);
      items.insert(newIndex, item);
    });
  }

  List<Widget> _getListItems() => items
      .asMap()
      .map((i, item) => MapEntry(i, _buildTenableListTile(item, i)))
      .values
      .toList();

  Widget _buildTenableListTile(Item item, int index) {
    return Dismissible(
      key: Key(item.itemId),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        // TODO: (MM fix warning "nullable return type")
        if (direction == DismissDirection.endToStart) {
          final bool res = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text(
                      "Tem certeza que você quer excluir da sua lista o item ${items[index].name}?"),
                  actions: <Widget>[
                    TextButton(
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        removeItem(index);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
          return res;
        }
      },
      background: Container(
        color: Theme.of(context).colorScheme.inversePrimary,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(Icons.delete),
      ),
      child: ListTile(
        leading: Checkbox(
          checkColor: Colors.white,
          // fillColor: MaterialStateProperty.resolveWith(getColor),
          value: item.wasBought,
          onChanged: (bool? value) {
            setState(() {
              item.wasBought = value!;
            });
          },
        ),
        trailing: ReorderableDragStartListener(
          index: index,
          child: const Icon(Icons.drag_indicator_outlined),
        ),
        key: ValueKey(item.itemId),
        title: Text(
          item.name,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          item.quantity,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        onTap: () {
          print("BBBBBBBBBBBB");
        },
      ),
    );
  }
}
