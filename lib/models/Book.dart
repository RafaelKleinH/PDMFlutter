class Book {
  final int? id;
  final String? name;
  final String? author;
  final String? date;
  final String? gender;
  final String? id_user;
  String? read;
  String? favorite;

  Book({
    this.id,
    this.name,
    this.author,
    this.date,
    this.gender,
    this.id_user,
    this.read,
    this.favorite,
  });

  @override
  String toString() {
    return 'Book{id: $id, name: $name, author: $author, date: $date, gender: $gender}';
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'author': author,
        'date': date,
        'gender': gender
      };

  factory Book.fromJson(Map<dynamic, dynamic> json) {
    return Book(
      id: json['i_id_livro'] as int?,
      name: json['c_nome_livro'] as String?,
      author: json['c_autor_livro'] as String?,
      date: json['c_data_livro'] as String?,
      gender: json['c_genero_livro'] as String?,
      id_user: json['c_id_usuario'] as String?,
      read: json['c_livro_lido'] as String?,
      favorite: json['c_livro_favorito'] as String?,
    );
  }
}
