import 'package:ez_calc/components/item.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  ItemCard(this.item, this.addItem, this.removeItem, {Key? key})
      : super(key: key);
  Item item;
  final void Function(Item) addItem;
  final void Function(Item) removeItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Container(
          height: 60,
          color: Colors.lightBlueAccent,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(item.nome,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          )),
                    )),
                Text(
                  "R\$ ${item.valor.toString()}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          removeItem(item);
                        },
                        child: const Icon(Icons.remove)),
                    Text(
                      "${item.quantidade}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          addItem(item);
                        },
                        child: const Icon(Icons.add)),
                  ],
                )
              ]),
        ),
      ),
      onTap: () {
        addItem(Item(item.nome, item.valor));
      },
    );
  }
}
