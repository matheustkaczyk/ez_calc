import 'package:flutter/material.dart';

import '../database/localDatabase.dart';
import 'item.dart';

class ItemModal extends StatelessWidget {
  late String productName;
  late double productValue;
  LocalDb localDb;

  final TextEditingController productController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

  ItemModal({super.key, required this.localDb});

  Future<AlertDialog> saveToDb() async {
    try {
      await localDb.addProduct(Item(productController.text, valueController.value as double));
      return const AlertDialog(content: Text("Produto cadastrado com sucesso!"),);
    } catch (e) {
      return const AlertDialog(content: Text("Erro"),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Produto"),
      content: SizedBox(
        height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: productController,
              decoration: InputDecoration(
              labelText: "Nome do Produto",
            ),

            ),
            TextField(
              controller: valueController,
              decoration: InputDecoration(
              labelText: "Valor",
            ),
              keyboardType: TextInputType.number,
            ),
            OutlinedButton(onPressed: () {
              saveToDb();
            }, child: const Text("Salvar"))
          ],
        )
      ),
      actions: [
        OutlinedButton(onPressed: () => Navigator.of(context).pop(), child: const Text("X"))
      ],
    );
  }
  
}