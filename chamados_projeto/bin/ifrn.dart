import 'dart:io';
import 'package:usuarios/usuarios.dart';
import 'package:chamados/chamados.dart';

const String version = '0.0.1';

void main(List<String> arguments) {
  List<Map<String,dynamic>> opcoes = [];
  
  // Exemplos de usuários com permissões diferentes
  // Estou usando um Map para simular a classe Usuario, mas você deve usar a classe real.
  Usuario usuario1 = UsuarioChamado(
    id: 1,
    nome: 'Fulano',
    email: 'fulano@gmail.com',
    senha: 'abc123',
    dataCadastro: DateTime(2026, 10, 12),
    permissoes: [],
    matricula: 20241101110099,
    campus: 'Caicó'
  );
  Usuario usuario2 = UsuarioChamado(
    id: 2,
    nome: 'Belttrano',
    email: 'belttrano@gmail.com',
    senha: 'abc123',
    dataCadastro: DateTime(2026, 10, 12),
    permissoes: ['admin'],
    matricula: 20241101110098,
    campus: 'Natal Zona Norte'
  );

  // Usuário logado
  var usuario = usuario2;

  opcoes += Chamado.menu;

  String? input;
  do {
    print('============= IFRN Suíte =============\n');

    print('Menu:');
    for (int i = 0; i < opcoes.length; i++) {
      print('$i - ${opcoes[i]['titulo']}');
    }
    print('\nDigite uma opção (ou "sair"):');
    input = stdin.readLineSync() ?? '';
    print('');
    int? escolha = int.tryParse(input);

    if (input == 'sair') {
      print('Obrigado por usar o IFRN Suíte. Até a próxima!');
    } else if (escolha != null && escolha >= 0 && escolha < opcoes.length) {
      // Se é necessária uma permissão e o usuário não tem, exibe mensagem de
      // acesso negado e continua o loop
      if (opcoes[escolha]['permissao'] != null && 
          !usuario.permissoes.contains(opcoes[escolha]['permissao'])) {
        print('Acesso negado. Você não tem permissão para fazer isso.\n');
        continue;
      }
      // Se chegou aqui, tem permissão, então executa o método correspondente
      // à opção escolhida
      opcoes[escolha]['metodo'](usuario);
    } else {
      print('Opção inválida.');
    }
    print('\nAperte ENTER para continuar...');
    stdin.readLineSync();
  } while (input != 'sair');
}
