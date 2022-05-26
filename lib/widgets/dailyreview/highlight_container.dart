import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:read_smart/models/Highlight.dart';

class HighlightContainer extends StatelessWidget {
  const HighlightContainer({required this.highlight, Key? key})
      : super(key: key);
  final HighlightExtended highlight;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(15.0),
        width: double.infinity,
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          // color: Colors.grey[900],
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Container(
                        width: 40,
                        height: 70,
                        child:
                            CachedNetworkImage(imageUrl: highlight.imageURL)),
                    SizedBox(width: 15),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            highlight.title,
                            style: GoogleFonts.openSans(
                                textStyle:
                                    Theme.of(context).textTheme.labelMedium),
                          ),
                          SizedBox(height: 5),
                          Text(
                            highlight.author,
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    highlight.highlight.text,
                    style: GoogleFonts.robotoSlab(
                        textStyle: Theme.of(context).textTheme.titleMedium),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
