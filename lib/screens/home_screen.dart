import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_smart/providers/highlights_provider.dart';
import 'package:read_smart/repository/auth_repository.dart';
import 'package:read_smart/providers/auth_provider.dart';
import 'package:read_smart/repository/highlights_repository.dart';

import '../models/Book.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   // "ref" can be used in all life-cycles of a StatefulWidget.
  //    ref.watch(HighlightsProvider.highlightsProvider);

  //   print('Chamei');
  // }

  @override
  Widget build(BuildContext context) {
    final highlights =
        ref.watch(HighlightsProvider.highlightsProvider).highlights;
    // print(userID);
    // final highLightRepository = HighlightRepository();

    // return Container(color: Colors.amber,);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Icon(
          Icons.notifications,
          color: Colors.white70,
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.thunderstorm,
              color: Colors.white70,
            ),
            tooltip: 'Streak',
            onPressed: () {
              // handle the press
            },
          ),
        ],
        title: Text(
          'Read Smart',
          style: TextStyle(color: Colors.white70),
        ),
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.grey[900],
      body: highlights.length > 0
          ? ListView.builder(
              itemCount: highlights.length,
              itemBuilder: (_, index) {
                final book = highlights[index].data();
                return _buildListItem(context, book);
              },
            )
          : CircularProgressIndicator(),
      // floatingActionButton: RedButton(),
      // body: StreamBuilder<QuerySnapshot>(
      //     stream: highlights,
      //     builder: (context, snapshot) {
      //       if (!snapshot.hasData) return LinearProgressIndicator();

      //       return _buildList(context, snapshot.data?.docs ?? []);
      //     }),
    );
  }
}

// Widget _buildList(BuildContext context, List<DocumentSnapshot>? snapshot) {
//   return ListView(
//     padding: const EdgeInsets.only(top: 20.0),
//     // 2
//     children: snapshot!.map((data) => _buildListItem(context, data)).toList(),
//   );
// }

// 3
Widget _buildListItem(BuildContext context, Book book) {
  // 4

  return Card(
      child: Container(
    height: 150,
    width: double.infinity,
    padding: EdgeInsets.all(10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      // mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Image.network(
            book.imageURL,
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
  ));
}
