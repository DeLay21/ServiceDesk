import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

const String _dominioPermitido = '@souunit.com.br';

class DomainNotAllowedException implements Exception {
  final String message;
  const DomainNotAllowedException(
      [this.message = 'Acesso restrito ao domínio @souunit.com.br']);
  @override
  String toString() => message;
}

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  static bool isDomainAllowed(String? email) {
    if (email == null || email.isEmpty) return false;
    return email.toLowerCase().endsWith(_dominioPermitido);
  }

  static Future<void> _rejeitarEDeslogar() async {
    try { await _googleSignIn.signOut(); } catch (_) {}
    await _auth.signOut();
    throw const DomainNotAllowedException();
  }

  static Future<UserCredential> signInEmailSenha({
    required String email,
    required String password,
  }) async {
    if (!isDomainAllowed(email)) {
      throw const DomainNotAllowedException();
    }

    final cred = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    if (!isDomainAllowed(cred.user?.email)) {
      await _rejeitarEDeslogar();
    }

    return cred;
  }

  static Future<UserCredential?> signInGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null; // cancelou


    if (!isDomainAllowed(googleUser.email)) {
      await _googleSignIn.signOut();
      throw const DomainNotAllowedException();
    }

    final googleAuth = await googleUser.authentication;

    final oauthCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final cred = await _auth.signInWithCredential(oauthCredential);

    if (!isDomainAllowed(cred.user?.email)) {
      await _rejeitarEDeslogar();
    }

    await _criarPerfilGoogle(cred.user!);

    return cred;
  }

  static Future<UserCredential> cadastrar({
    required String email,
    required String password,
    required String nome,
    required String dataNasc,
  }) async {
    if (!isDomainAllowed(email)) {
      throw const DomainNotAllowedException();
    }

    final cred = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    if (!isDomainAllowed(cred.user?.email)) {
      await cred.user?.delete();
      await _rejeitarEDeslogar();
    }

    await _db.collection('usuarios').doc(cred.user!.uid).set({
      'nome': nome.trim(),
      'email': email.trim(),
      'dataNascimento': dataNasc.trim(),
      'sexo': '',
      'fotoPerfil': '',
      'criadoEm': FieldValue.serverTimestamp(),
      'provider': 'email',
    });

    return cred;
  }

  static Future<void> signOut() async {
    try { await _googleSignIn.signOut(); } catch (_) {}
    await _auth.signOut();
  }

  static Future<void> _criarPerfilGoogle(User user) async {
    final ref = _db.collection('usuarios').doc(user.uid);
    final doc = await ref.get();
    if (!doc.exists) {
      await ref.set({
        'nome': user.displayName ?? '',
        'email': user.email ?? '',
        'dataNascimento': '',
        'sexo': '',
        'fotoPerfil': user.photoURL ?? '',
        'criadoEm': FieldValue.serverTimestamp(),
        'provider': 'google',
      });
    }
  }
}