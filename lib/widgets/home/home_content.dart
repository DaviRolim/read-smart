import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_smart/models/Book.dart';
import 'package:read_smart/providers/highlights_provider.dart';

class HomeContent extends ConsumerStatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends ConsumerState<HomeContent> {
  @override
  Widget build(BuildContext context) {
   final highlights =
        ref.watch(HighlightsProvider.highlightsProvider).highlights;
    return highlights.length > 0
          ? ListView.builder(
              itemCount: highlights.length,
              itemBuilder: (_, index) {
                final book = highlights[index].data();
                return _buildListItem(context, book);
              },
            )
          : CircularProgressIndicator();
  }
}

Widget _buildListItem(BuildContext context, Book book) {
  // 4

  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.grey[900],
        elevation: 5,
        child: Container(
          height: 250,
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: CachedNetworkImage(
                  imageUrl: book.imageURL,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  color: Colors.white.withOpacity(0.8),
                  colorBlendMode: BlendMode.modulate,
                ),
              ),
              Flexible(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    book.title,
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  // SizedBox(height: 15,),
                  Text(
                    book.author,
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              )),
            ],
          ),
        )),
  );
}