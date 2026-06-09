import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsuarioService {
  static final _auth = FirebaseAuth.instance;
  static final _db = FirebaseFirestore.instance;

  static String get uid => _auth.currentUser!.uid;

  static Future<Map<String, dynamic>> buscarPerfil() async {
    final doc = await _db.collection('usuarios').doc(uid).get();
    return doc.data() ?? {};
  }

  // atualiza os dados do usuário
  static Future<void> atualizarPerfil(Map<String, dynamic> dados) async {
    try {
      await _db.collection('usuarios').doc(uid).update(dados);
    } catch (e) {
      throw Exception('Erro ao atualizar perfil: $e');
    }
  }

  static Future<void> atualizarEmail(
    String senhaAtual,
    String novoEmail,
  ) async {
    try {
      final user = _auth.currentUser!;

      final credencial = EmailAuthProvider.credential(
        email: user.email!,
        password: senhaAtual,
      );
      await user.reauthenticateWithCredential(credencial);

      await user.verifyBeforeUpdateEmail(novoEmail);
    } catch (e) {
      throw Exception('Erro ao atualizar email: $e');
    }
  }

  static Future<void> alterarSenha(String senhaAtual, String novaSenha) async {
    try {
      final user = _auth.currentUser!;

      final credencial = EmailAuthProvider.credential(
        email: user.email!,
        password: senhaAtual,
      );
      await user.reauthenticateWithCredential(credencial);

      await user.updatePassword(novaSenha);
    } catch (e) {
      throw Exception('Erro ao alterar: $e');
    }
  }

  // utilidades -----

  static Future<bool> existsByEmail(String email) async {
    final perfilAtual = await buscarPerfil();
    final emailAtual = perfilAtual['email'] ?? '';

    if (email == emailAtual) {
      return false;
    }

    final query = await _db
        .collection('usuarios')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    return query.docs.isNotEmpty;
  }
}
