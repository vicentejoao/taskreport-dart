import 'item.dart';

class Tarefa extends Item {
  String responsavel;
  String status;
  String prioridade;
  double valor;
  int horas;

  static final Map<int, List<String>> _inconsistenciasPorId = {};

  Tarefa.fromMap(Map<String, dynamic> map)
    : responsavel = _lerCampoString(map, 'responsavel', 'Não informado'),
      status = _lerCampoString(map, 'status', 'Sem status'),
      prioridade = _lerCampoString(map, 'prioridade', 'Sem prioridade'),
      valor = _lerValor(map, 0),
      horas = _lerHoras(map, 0),
      super(map['id'] as int, _lerCampoString(map, 'titulo', 'Sem título'));

  static void _addInconsistencia(int id, String campo, String inconsistencia) {
    if (_inconsistenciasPorId.containsKey(id)) {
      _inconsistenciasPorId[id]!.add(inconsistencia);
    } else {
      _inconsistenciasPorId[id] = [inconsistencia];
    }
  }

  static String _lerCampoString(
    Map<String, dynamic> map,
    String campo,
    String valorPadrao,
  ) {
    if (map[campo] == null) {
      _addInconsistencia(map['id'], campo, '$campo ausente');
      return valorPadrao;
    }
    return (map[campo] as String).trim();
  }

  static double _lerValor(Map<String, dynamic> map, double valorPadrao) {
    if (map['valor'] == null) {
      _addInconsistencia(map['id'], 'valor', 'valor ausente');
      return valorPadrao;
    }

    String valor = (map['valor'] as String)
        .trim()
        .substring(3)
        .replaceAll(',', '.');

    double? valorConvertido = double.tryParse(valor);
    if (valorConvertido == null) {
      _addInconsistencia(map['id'], 'valor', 'valor inválido');
      return valorPadrao;
    }
    return valorConvertido;
  }

  static int _lerHoras(Map<String, dynamic> map, int valorPadrao) {
    if (map['horas'] == null) {
      _addInconsistencia(map['id'], 'horas', 'horas ausente');
      return valorPadrao;
    }

    int? horasConvertido = int.tryParse((map['horas'] as String).trim());
    if (horasConvertido == null) {
      _addInconsistencia(map['id'], 'horas', 'horas inválido');
      return valorPadrao;
    }
    return horasConvertido;
  }

  static Map<int, List<String>> get inconsistenciasPorId =>
      _inconsistenciasPorId;

  @override
  String toString() {
    return '''ID: $id
Título: $titulo
Responsável: $responsavel
Status: $status
Prioridade: $prioridade
Valor: R\$ $valor
Horas: $horas''';
  }
}
