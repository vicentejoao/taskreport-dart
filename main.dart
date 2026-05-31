import 'dados_tarefas.dart';
import 'tarefa.dart';

void main() {
  List<Tarefa> tarefas = dadosTarefas.map(Tarefa.fromMap).toList();
  print('TAREFAS CONVERTIDAS\n');
  tarefas.forEach(print);
  print('');

  print('Tarefas concluídas:');
  List<Tarefa> concluidas = tarefas
      .where((t) => t.status == 'concluída')
      .toList();
  concluidas.forEach(printTitulo);
  print('');

  print('Tarefas em andamento:');
  List<Tarefa> emAndamento = tarefas
      .where((t) => t.status == 'em andamento')
      .toList();
  emAndamento.forEach(printTitulo);
  print('');

  print('Tarefas pendentes:');
  List<Tarefa> pendentes = tarefas
      .where((t) => t.status == 'pendente')
      .toList();
  pendentes.forEach(printTitulo);
  print('');

  print('Tarefas canceladas:');
  List<Tarefa> canceladas = tarefas
      .where((t) => t.status == 'cancelada')
      .toList();
  canceladas.forEach(printTitulo);
  print('');

  double totalConcluidas = concluidas
      .map((t) => t.valor)
      .fold<double>(0, (ant, atual) => ant + atual);
  print(
    'Total de tarefas concluídas: R\$ ${totalConcluidas.toStringAsFixed(2)}',
  );

  if (pendentes.isEmpty) {
    print("Não existem tarefas pendentes para calcular média.");
  } else {
    double mediaPendentes =
        pendentes
            .map((t) => t.valor)
            .fold<double>(0, (ant, atual) => ant + atual) /
        pendentes.length;
    print(
      'Média de valor das tarefas pendentes: R\$ ${mediaPendentes.toStringAsFixed(2)}',
    );
  }
  print('');

  Map<String, int> horasPorStatus = calcularHorasPorStatus(tarefas);
  print('Horas por status:');
  for (final hps in horasPorStatus.entries) {
    print('${hps.key}: ${hps.value} horas');
  }
  print('');

  print('Tarefas com dados incompletos:');
  for (final ipd in Tarefa.inconsistenciasPorId.entries) {
    print(
      '- ID ${ipd.key}: ${ipd.value.reduce((ant, atual) => '$ant e $atual')}',
    );
  }
  print('');

  Set<String> statusEncontrados = tarefas.map((t) => t.status).toSet();
  print('Status encontrados: ');
  statusEncontrados.forEach(print);
  print('');
}

void printTitulo(Tarefa t) {
  print('- ${t.titulo}');
}

Map<String, int> calcularHorasPorStatus(List<Tarefa> tarefas) {
  Map<String, int> hps = {};
  for (Tarefa t in tarefas) {
    hps.update(t.status, (self) {
      self += t.horas;
      return self;
    }, ifAbsent: () => t.horas);
  }
  return hps;
}
