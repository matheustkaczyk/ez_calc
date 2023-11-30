import 'package:ez_calc/utils/hash.dart';

class Item {
  final String? id = md5RandomString();
  final String nome;
  final double valor;
  int quantidade = 0;

  Item(this.nome, this.valor);
}
