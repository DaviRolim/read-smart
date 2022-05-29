import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helpers/custom_page_route.dart';
import '../models/Book.dart';
import '../providers/highlights_provider.dart';
import 'HighlightScreen.dart';
import 'home_screen.dart';

class BooksScreen extends ConsumerStatefulWidget {
  static const routeName = 'books';
  const BooksScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<BooksScreen> createState() => _BooksScreenState();
}

// Im typing super fast doing a lot of cool things with vim
class _BooksScreenState extends ConsumerState<BooksScreen> {
  List<Book> books = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    books = ref.watch(HighlightsProvider.highlightsProvider).filteredHighlights;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.of(context)
                .pushReplacementNamed(HomeScreen.routeName)),
        centerTitle: true,
        title: Text(
          'Your Books',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.64,
                      height: 40,
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Search Books',
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))
                            //fillColor: Theme.of(context).colorScheme.secondary,
                            ),
                        onChanged: ref
                            .read(HighlightsProvider.highlightsProvider)
                            .filterBooks,
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.sort),
                        onPressed: () => ref
                            .read(HighlightsProvider.highlightsProvider)
                            .sortBooks())
                  ],
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return Column(
                      children: [
                        ListTile(
                            //tileColor: Theme.of(context).colorScheme.primaryContainer,
                            leading: Container(
                                height: 50,
                                width: 50,
                                child: CachedNetworkImage(
                                    imageUrl: book.imageURL)),
                            title: Text(
                              book.title,
                              style: Theme.of(context).textTheme.titleSmall,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            subtitle: Text(book.author,
                                style: TextStyle(fontSize: 12)),
                            trailing: Text(book.highlights.length.toString(),
                                style: TextStyle(fontSize: 12)),
                            onTap: () {
                              Navigator.of(context).push(
                                  CustomPageRoute(HighlightScreen(book: book)));
                            }),
                        Divider(
                          thickness: 2,
                        ),
                      ],
                    );
                  }),
              // if (books.isNotEmpty)
              //   ...books.map((e) {
              //     final book = e.data();
              //     return Column(
              //       children: [
              //         Divider(),
              //       ],
              //     );
              //   }).toList()
            ],
          ),
        ),
      ),
    );
  }
}
