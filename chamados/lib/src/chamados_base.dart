import 'dart:io';

class UsuarioChamado { // extends Usuario

  final int id;
  final String nome;
  final int matricula;
  final String senha;
  final String campus;
  final List<Chamado> chamados;

  const UsuarioChamado({

    required this.id,
    required this.nome,
    required this.matricula,
    required this.senha,
    required this.campus,
    required this.chamados,
  });
}

class Chamado {
  final int id;
  String descricao;
  final UsuarioChamado usuario;
  final String campus;
  List<String> interessados;
  final String status;

  Chamado({
    required this.id,
    required this.descricao,
    required this.usuario,
    required this.campus,
    required this.interessados,
    this.status = 'Pendente'
  });
}