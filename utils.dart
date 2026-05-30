import 'main.dart';

String lerTitulo(Map<String, dynamic> map) {
  if (map['titulo'] == null) {
    erros.update(map['id'].toString(), (lista) {
      lista.add('Título ausente');
      return lista;
    }, ifAbsent: () => ['Título ausente']);
    return 'Sem título';
  }
  return map['titulo'];
}

String lerResponsavel(Map<String, dynamic> map) {
  if (map['responsavel'] == null) {
    erros.update(map['id'].toString(), (lista) {
      lista.add('Responsável ausente');
      return lista;
    }, ifAbsent: () => ['Responsável ausente']);
    return 'Não informado';
  }
  return map['responsavel'];
}

String lerStatus(Map<String, dynamic> map) {
  if (map['status'] == null) {
    erros.update(map['id'].toString(), (lista) {
      lista.add('Status ausente');
      return lista;
    }, ifAbsent: () => ['Status ausente']);
    return 'Sem status';
  }
  return map['status'];
}

String lerPrioridade(Map<String, dynamic> map) {
  if (map['prioridade'] == null) {
    erros.update(map['id'].toString(), (lista) {
      lista.add('Prioridade ausente');
      return lista;
    }, ifAbsent: () => ['Prioridade ausente']);
    return 'Sem prioridade';
  }

  return map['prioridade'];
}

double lerValor(Map<String, dynamic> map) {
  if (map['valor'] == null) {
    erros.update(map['id'].toString(), (lista) {
      lista.add('Valor ausente');
      return lista;
    }, ifAbsent: () => ['Valor ausente']);
    return 0;
  }
  String valor = map['valor'] as String;
  return double.parse(valor.substring(3).replaceAll(',', '.'));
}

int lerHoras(Map<String, dynamic> map) {
  if (map['horas'] == null) {
    erros.update(map['id'].toString(), (lista) {
      lista.add('Horas ausente');
      return lista;
    }, ifAbsent: () => ['Horas ausente']);
    return 0;
  }
  return int.tryParse(map['horas'] ?? '0') ?? 0;
}
