import 'package:flutter/material.dart';

import '../models/Book.dart';

class HighlightScreen extends StatelessWidget {
  final Book book;
  const HighlightScreen({required this.book, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final highlights = book.highlights;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.of(context).pop()),
        centerTitle: true,
        title: Text(
          book.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(height: 10),
          ...highlights
              .map((e) => Container(
                    margin: EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Center(
                          child: Text(e.text,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 16)),
                        ),
                      ),
                    ),
                  ))
              .toList()
        ],
      )),
    );
  }
}
