import 'dados_tarefas.dart';
import 'tarefa.dart';

void main() {
  List<Tarefa> tarefas = dadosTarefas.map(Tarefa.fromMap).toList();
  print('TAREFAS CONVERTIDAS\n');
  tarefas.forEach(print);
}
