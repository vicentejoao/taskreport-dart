import 'dados_tarefas.dart';
import 'tarefa.dart';

void main() {
  List<Tarefa> tarefas = dadosTarefas.map(Tarefa.fromMap).toList();
  print('TAREFAS CONVERTIDAS\n');
  tarefas.forEach(print);
  print('');

  List<Tarefa> concluidas = tarefas
      .where((t) => t.status == 'concluída')
      .toList();
  print('Tarefas concluídas:');
  concluidas.forEach(printTitulo);
  print('');

  List<Tarefa> emAndamento = tarefas
      .where((t) => t.status == 'em andamento')
      .toList();
  print('Tarefas em andamento:');
  emAndamento.forEach(printTitulo);
  print('');

  List<Tarefa> pendentes = tarefas
      .where((t) => t.status == 'pendente')
      .toList();
  print('Tarefas pendentes:');
  pendentes.forEach(printTitulo);
  print('');

  List<Tarefa> canceladas = tarefas
      .where((t) => t.status == 'cancelada')
      .toList();
  print('Tarefas canceladas:');
  canceladas.forEach(printTitulo);
  print('');

  //--------------------------------------------------------------------/
  double valorConcluidas = concluidas
      .map((t) => t.valor)
      .fold<double>(0, (ant, atual) => ant + atual);
  print(
    'Total de tarefas concluídas: R\$ ${valorConcluidas.toStringAsFixed(2)}',
  );

  double pendentesValorMedio = 0;
  if (pendentes.isEmpty) {
    print("Não existem tarefas pendentes para calcular média.");
  } else {
    pendentesValorMedio =
        pendentes
            .map((t) => t.valor)
            .fold<double>(0, (ant, atual) => ant + atual) /
        pendentes.length;
    print(
      'Média de valor das tarefas pendentes: R\$ ${pendentesValorMedio.toStringAsFixed(2)}',
    );
  }
  print('');

  //--------------------------------------------------------------------/
  Map<String, int> horasPorStatus = calcularHorasPorStatus(tarefas);
  print('Horas por status:');
  for (final hps in horasPorStatus.entries) {
    print('${hps.key}: ${hps.value} horas');
  }
  print('');

  print('Tarefas com dados incompletos:');
  printInconsistencias();
  print('');

  Set<String> statusEncontrados = tarefas.map((t) => t.status).toSet();
  print('Status encontrados: ');
  statusEncontrados.forEach(print);
  print('');

  //--------------------------------------------------------------------/
  print('RELATÓRIO FINAL DE TAREFAS');
  print('');
  print('Total de tarefas analisadas: ${tarefas.length}');
  print('Tarefas concluídas: ${concluidas.length}');
  print('Tarefas pendentes: ${pendentes.length}');
  print('Tarefas em andamento: ${emAndamento.length}');
  print('Tarefas canceladas: ${canceladas.length}');
  print('');
  print(
    'Valor total das concluídas: R\$ ${valorConcluidas.toStringAsFixed(2)}',
  );
  print(
    'Média de valor das pendentes: R\$ ${pendentesValorMedio.toStringAsFixed(2)}',
  );
  print(
    'Total de horas concluídas: ${concluidas.map((t) => t.horas).reduce((ant, atual) => ant + atual)}',
  );
  print('');
  print('Status encontrados:');
  statusEncontrados.forEach(print);
  print('');
  print('Tarefas com dados incompletos:');
  for (final int id in Tarefa.inconsistenciasPorId.keys) {
    print('ID $id - ${tarefas.firstWhere((t) => t.id == id).titulo}');
  }
}

void printTitulo(Tarefa tarefa) {
  print('- ${tarefa.titulo}');
}

void printInconsistencias() {
  for (final ipd in Tarefa.inconsistenciasPorId.entries) {
    print(
      'ID ${ipd.key}: ${ipd.value.reduce((ant, atual) => '$ant e $atual')}',
    );
  }
}

Map<String, int> calcularHorasPorStatus(List<Tarefa> tarefas) {
  Map<String, int> horasPorStatus = {};
  for (Tarefa t in tarefas) {
    horasPorStatus.update(t.status, (self) {
      self += t.horas;
      return self;
    }, ifAbsent: () => t.horas);
  }
  return horasPorStatus;
}
