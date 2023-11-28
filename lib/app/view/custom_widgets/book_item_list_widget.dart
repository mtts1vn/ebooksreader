// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ebooksreader/app/api/book/book_downloader_manager.dart';
import 'package:ebooksreader/app/features/download/http_download_file.dart';
import 'package:flutter/material.dart';
import 'package:ebooksreader/app/model/book_model.dart';

class BookItem extends StatelessWidget {
  final Book book;

  const BookItem({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BookDownloadManager bookDownloader = BookDownloadManager(
          repositoryDownload: HttpDownloadFile(),
        );

        bookDownloader.downloadAndSaveBook(context, book, "epub");
      },
      child: Column(
        children: [
          Expanded(
              child: Image.network(
            book.coverUrl,
            fit: BoxFit.cover,
          )),
          Text(
            book.title,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Theme.of(context).textTheme.labelLarge?.fontSize),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            book.author,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
