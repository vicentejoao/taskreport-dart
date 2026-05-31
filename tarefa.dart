import 'item.dart';

class Tarefa extends Item {
  String responsavel;
  String status;
  String prioridade;
  double valor;
  int horas;

  static final Map<int, List<String>> _inconsistenciasPorId = {};
  static Map<int, List<String>> inconsistenciasPorId = _inconsistenciasPorId;

  static void _addInconsistencia(int id, String campo, String inconsistencia) {
    _inconsistenciasPorId.update(id, (self) {
      self.add(inconsistencia);
      return self;
    }, ifAbsent: () => [inconsistencia]);
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
    : responsavel = _lerCampoString(map, 'responsavel', 'Não informado'),
      status = _lerCampoString(map, 'status', 'Sem status'),
      prioridade = _lerCampoString(map, 'prioridade', 'Sem prioridade'),
      valor = _lerValor(map, 0),
      horas = _lerHoras(map, 0),
      super(map['id'] as int, _lerCampoString(map, 'titulo', 'Sem título'));

  @override
  String toString() {
    return "$id - $titulo - $responsavel - $status - $prioridade - $valor - $horas";
  }
}
