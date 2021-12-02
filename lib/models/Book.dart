class Book {
  final int id;
  final String name;
  final String author;
  final String date;
  final String gender;

  Book(
    this.id,
    this.name,
    this.author,
    this.date,
    this.gender,
  );

  @override
  String toString() {
    return 'Book{id: $id, name: $name, author: $author, date: $date, gender: $gender}';
  }
}
