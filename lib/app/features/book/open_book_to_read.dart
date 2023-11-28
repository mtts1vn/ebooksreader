import 'package:flutter/material.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class OPenBookToRead {
  static void openBook(BuildContext context, String filePath) async {
    VocsyEpub.setConfig(
      themeColor: Theme.of(context).primaryColor,
      identifier: "book",
      scrollDirection: EpubScrollDirection.HORIZONTAL,
      allowSharing: true,
      enableTts: true,
      nightMode: false,
    );

    VocsyEpub.open(
      filePath,
      lastLocation: EpubLocator.fromJson({
        "bookId": "2239",
        "href": "/OEBPS/ch06.xhtml",
        "created": 1539934158390,
        "locations": {"cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"}
      }),
    );
  }
}
