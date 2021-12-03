class User {
  final String c_nome_usuario;
  final String c_senha;
  final int i_id_usuario;

  User({
    required this.c_nome_usuario,
    required this.c_senha,
    required this.i_id_usuario,
  });

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
      c_nome_usuario: json['usuario'] as String,
      c_senha: json['senha'] as String,
      i_id_usuario: json['id'] as int,
    );
  }
}
