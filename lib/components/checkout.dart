import 'package:flutter/material.dart';

class Checkout extends StatefulWidget {
  final TextEditingController trocoController;
  final String calc;
  final void Function() clear;

  const Checkout({super.key, required this.trocoController, required this.calc, required this.clear});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  late FocusNode _trocoFocusNode;

  @override
  void initState() {
    super.initState();
    _trocoFocusNode = FocusNode();
    _trocoFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _trocoFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Checkout",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              focusNode: _trocoFocusNode,
              controller: widget.trocoController,
              decoration: const InputDecoration(
                labelText: "TROCO",
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Troco: R\$ ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text("${
                    (double.parse(widget.trocoController.text) - double.parse(widget.calc) > 0
                        ? (double.parse(widget.trocoController.text) - double.parse(widget.calc)).toStringAsFixed(2)
                        : 0)
                }", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.lightBlue, fontSize: 20.0),),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Finalizar', style: TextStyle(color: Colors.white)),
              onPressed: () => {
                Navigator.pop(context),
                widget.clear()
              },
            ),
          ],
        ),
      ),
    );
  }

}