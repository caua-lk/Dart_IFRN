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

class Chamado {
  final int id;
  String descricao;
  final UsuarioChamado usuario;
  final String campus;
  List<String> interessados;
  final String status;

  static List<Chamado> instancias = [];

  Chamado({
    required this.id,
    required this.descricao,
    required this.usuario,
    required this.campus,
    required this.interessados,
    this.status = 'Pendente'
  }) {
    instancias.add(this);
  }

  static List<Map<String, dynamic>> menu = [
    { 'titulo': 'Listar chamados', 'permissao': null, 'metodo': listar },
    { 'titulo': 'Abrir chamado', 'permissao': 'admin', 'metodo': cadastrar },
    { 'titulo': 'Fechar chamado', 'permissao': 'admin', 'metodo': excluir },
  ];

  static void listar() {
    if (instancias.isEmpty) {
      print('Você não possui chamados registrados.');
    } else {
      for (final Chamado chamado in instancias) {
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
}