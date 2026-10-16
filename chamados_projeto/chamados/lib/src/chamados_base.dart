import 'dart:io';
import 'package:usuarios/usuarios.dart';

// Classe de usuário que herda da classe de usuári odo grupo 1 (Marcos)
class UsuarioChamado extends Usuario {
  final int matricula;
  final String campus;
  final List<Chamado> chamados;

  UsuarioChamado({
    required super.id,
    required super.nome,
    required super.email,
    required super.dataCadastro,
    required this.matricula,
    required super.senha,
    required this.campus,
    required this.chamados,
    List<String>? permissoes
  });
}

class ChamadoModel {
  final int id;
  String descricao;
  final UsuarioChamado usuario;
  final String campus;
  List<String> interessados;
  final String status;

  static List<ChamadoModel> instancias = [];

  ChamadoModel({
    required this.id,
    required this.descricao,
    required this.usuario,
    required this.campus,
    required this.interessados,
    this.status = 'Pendente'
  }) {
    instancias.add(this);
  }
}

class Chamado {
  static List<Map<String, dynamic>> menu = [
    { 'titulo': 'Listar chamados', 'permissao': null, 'metodo': listar },
    { 'titulo': 'Abrir chamado', 'permissao': null, 'metodo': cadastrar },
    { 'titulo': 'Fechar chamado', 'permissao': null, 'metodo': excluir },
  ];

  static void listar(UsuarioChamado usuario) {
    if (ChamadoModel.instancias.isEmpty) {
      print('Você não possui chamados registrados.');
    } else {
      for (final chamado in ChamadoModel.instancias) {
        String textoInteressados = '\n';
        for (final usuario in chamado.interessados) {
          textoInteressados += '$usuario\n';
        }

        print('''
        -------------------
        ${chamado.descricao} (${chamado.status})
        Usuário: ${chamado.usuario}
        Campus: ${chamado.campus}
        Interessados: $textoInteressados
        -------------------
        ''');
      }
    }
  }

  static void cadastrar(UsuarioChamado usuario) {
    print('Insira um campus para o chamado:');
    String? campus = stdin.readLineSync();
    if (campus == null) {
      print('É preciso informar um campus para abrir chamado.');
      return;
    }

    print('Insira a descrição do chamado');
    String descricao = stdin.readLineSync() ?? 'Sem descrição';

    print('Insira o nome dos interessados, separados por vírgula:');
    String? interessadosTexto = stdin.readLineSync();
    List<String> interessados = [];
    if (interessadosTexto != null) {
      interessados = interessadosTexto.trim().split(',');
    }

    ChamadoModel(
      id: ChamadoModel.instancias.length + 1,
      descricao: descricao,
      usuario: usuario,
      campus: campus,
      interessados: interessados
    );
  }

  static void excluir(UsuarioChamado usuario) {
    print('Insira o id do chamado que deseja fechar:');
    int? id = int.tryParse(stdin.readLineSync() ?? '');
    if (id == null) {
      print('Valor inválido digitado.');
      return;
    }
    for (final chamado in ChamadoModel.instancias) {
      if (chamado.id == id) {
        if (chamado.usuario != usuario) {
          print('Você não tem permissão para fechar este chamado.');
          return;
        }
        ChamadoModel.instancias.remove(chamado);
        print('Chamado fechado com sucesso.');
        return;
      }
    }
    print('Nenhum chamado com este id foi encontrado.');
    return;
  }
}