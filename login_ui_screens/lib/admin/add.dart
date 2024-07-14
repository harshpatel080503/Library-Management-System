import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class addbook extends StatefulWidget {
  const addbook({super.key});

  @override
  State<addbook> createState() => _addbookState();
}

class _addbookState extends State<addbook> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _isbnController = TextEditingController();
  final TextEditingController _imageURLController = TextEditingController();
  final TextEditingController _publisherController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _authorController,
                decoration: InputDecoration(labelText: 'Author'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: _genreController,
                decoration: InputDecoration(labelText: 'Genre'),
              ),
              TextField(
                controller: _isbnController,
                decoration: InputDecoration(labelText: 'ISBN'),
              ),
              TextField(
                controller: _imageURLController,
                decoration: InputDecoration(labelText: 'Image URL'),
              ),
              TextField(
                controller: _publisherController,
                decoration: InputDecoration(labelText: 'Publisher'),
              ),
              TextField(
                controller: _yearController,
                decoration: InputDecoration(labelText: 'Year'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _statusController,
                decoration: InputDecoration(labelText: 'Status'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final title = _titleController.text;
                  final author = _authorController.text;
                  final description = _descriptionController.text;
                  final genre = _genreController.text;
                  final isbn = _isbnController.text;
                  final imageURL = _imageURLController.text;
                  final publisher = _publisherController.text;
                  final year = int.tryParse(_yearController.text) ?? 0;
                  final quantity = int.tryParse(_quantityController.text) ?? 0;
                  final status = _statusController.text;

                  if (title.isNotEmpty && author.isNotEmpty) {
                    await _firestoreService.addBook(Book(
                      id: '',
                      title: title,
                      author: author,
                      description: description,
                      genre: genre,
                      isbn: isbn,
                      imageURL: imageURL,
                      publisher: publisher,
                      year: year,
                      quantity: quantity,
                      status: status,
                    ));
                    Navigator.pop(context);
                  }
                },
                child: Text('Add Book'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Book {
  String id;
  String title;
  String author;
  String description;
  String genre;
  String isbn;
  String imageURL;
  String publisher;
  int year;
  int quantity;
  String status;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.genre,
    required this.isbn,
    required this.imageURL,
    required this.publisher,
    required this.year,
    required this.quantity,
    required this.status,
  });

  factory Book.fromDocument(DocumentSnapshot doc) {
    return Book(
      id: doc.id,
      title: doc['title'],
      author: doc['author'],
      description: doc['description'],
      genre: doc['genre'],
      isbn: doc['isbn'],
      imageURL: doc['imageURL'],
      publisher: doc['publisher'],
      year: doc['year'],
      quantity: doc['quantity'],
      status: doc['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Title': title,
      'Author': author,
      'Description': description,
      'Genre': genre,
      'ISBN': isbn,
      'ImageURL': imageURL,
      'Publisher': publisher,
      'Year': year,
      'Quantity': quantity,
      'Status': status,
    };
  }
}

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Book>> getBooks() {
    return _db.collection('book').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Book.fromDocument(doc)).toList());
  }

  Future<void> addBook(Book book) {
    return _db.collection('book').add(book.toMap());
  }

  Future<void> updateBook(Book book) {
    return _db.collection('book').doc(book.id).update(book.toMap());
  }

  Future<void> deleteBook(String id) {
    return _db.collection('book').doc(id).delete();
  }
}
