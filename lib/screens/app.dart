import 'package:ez_calc/components/itemModal.dart';
import 'package:ez_calc/database/localDatabase.dart';
import 'package:flutter/material.dart';

import 'package:ez_calc/components/checkout.dart';
import 'package:ez_calc/components/itemCard.dart';
import '../components/item.dart';

class EzCalc extends StatefulWidget {
  String calc = "0.00";
  final trocoController = TextEditingController(text: "0");
  late LocalDb localDb;

  EzCalc({Key? key}) : super(key: key);

  @override
  _EzCalcState createState() => _EzCalcState();
}

class _EzCalcState extends State<EzCalc> {
  late Item newItem;

  List<Item> items = [
    Item("Pilsen", 10.00),
    Item("IPA", 12.00),
    Item("APA", 12.00),
    Item("Vinho", 12.00),
    Item("Erva Mate", 12.00),
    Item("Growler 1l", 15.00),
    Item("Growler 2l", 30.00)
  ];

  @override
  void initState() {
    super.initState();
    widget.localDb = LocalDb();
    fetchProducts();
  }

  void fetchProducts () async {
    var products = await widget.localDb.getProducts();

    if (products.isNotEmpty) {

    }
  }

  void incrementQuantity(Item item) {

    for (int i = 0; i < items.length; i++) {
      if (items[i].nome == item.nome) {
        items[i].quantidade += 1;
      }
    }
    updateCalc();
  }

  void decrementQuantity(Item item) {
    for (int i = 0; i < items.length; i++) {
      if (items[i].nome == item.nome) {
        if (items[i].quantidade > 0) {
          items[i].quantidade -= 1;
        }
      }
    }
    updateCalc();
  }

  void clearItems() {
    for (var item in items) {
      item.quantidade = 0;
    }

    widget.trocoController.text = 0.toString();

    updateCalc();
  }

  void updateCalc() {
    double total =
    items.fold(0.0, (sum, item) => sum + item.valor * item.quantidade);
    setState(() {
      total < 0 ? widget.calc = "0.0" : widget.calc = total.toStringAsFixed(2);
    });
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog(context: context, builder: (BuildContext context) {
      return ItemModal(localDb: widget.localDb,);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EZ Calc',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 310,
                    child: Row(
                      children: [
                        const Text(
                          "TOTAL ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                            "R\$ ${widget.calc}",
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.lightGreenAccent)
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(onPressed: () => _dialogBuilder(context), child: const Icon(Icons.add))
                ],
              ),
            ],
          ),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(4),
          itemCount: items.length,
          itemBuilder: (BuildContext buildContext, int index) {
            return ItemCard(items[index], incrementQuantity, decrementQuantity);
          },
        ),
        bottomNavigationBar: GestureDetector(
          onVerticalDragUpdate: (details) {
            if (details.primaryDelta! < -10) {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Checkout(
                      trocoController: widget.trocoController,
                      calc: widget.calc,
                      clear: clearItems,
                  );
                },
              );
            }
          },
          child: Container(
            height: 100, // Adjust the height as needed
            color: Colors.blue, // Add the desired color
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_upward_rounded, color: Colors.white, size: 35),
                  Text("Checkout", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),)
                ],
              )
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            clearItems();
          },
          child: const Icon(Icons.west_outlined),
        ),
      ),
    );
  }
}