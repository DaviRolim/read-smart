import '../models/Book.dart';

abstract class IBookRepository {
  List<Book> getBooks();
}
