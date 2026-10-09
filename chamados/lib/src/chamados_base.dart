import 'dart:io';

class Chamado {
  final int id;
  String descricao;
  final int usuarioId;
  final String campus;
  List<String> interessados;
  final String status;

  Chamado({
    required this.id,
    required this.descricao,
    required this.usuarioId,
    required this.campus,
    required this.interessados,
    this.status = 'Pendente'
  });
}