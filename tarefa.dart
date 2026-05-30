import 'item.dart';
import 'utils.dart';

class Tarefa extends Item {
  String responsavel;
  String status;
  String prioridade;
  double valor;
  int horas;

  Tarefa({
    required int id,
    required String titulo,
    required this.responsavel,
    required this.status,
    required this.prioridade,
    required this.valor,
    required this.horas,
  }) : super(id, titulo);

  Tarefa.fromMap(Map<String, dynamic> map)
    : responsavel = lerResponsavel(map),
      status = lerStatus(map),
      prioridade = lerPrioridade(map),
      valor = lerValor(map),
      horas = lerHoras(map),
      super(map['id'] as int, lerTitulo(map));

  @override
  String toString() {
    return "$id - $titulo - $responsavel - $status - $prioridade - $valor - $horas";
  }
}
