// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebooksreader/app/features/book/book_downloader_manager.dart';
import 'package:ebooksreader/app/features/download/http_download_file.dart';
import 'package:ebooksreader/app/features/favorites/favorites_interface.dart';
import 'package:ebooksreader/app/features/snackbar/snakbar.dart';
import 'package:ebooksreader/get_it/locator.dart';
import 'package:flutter/material.dart';
import 'package:ebooksreader/app/model/book_model.dart';

class BookItem extends StatefulWidget {
  final Book book;

  const BookItem({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  State<BookItem> createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BookDownloadManager bookDownloader = BookDownloadManager(
          repositoryDownload: HttpDownloadFile(),
        );

        bookDownloader.downloadAndSaveBook(context, widget.book, "epub");
      },
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.book.coverUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  alignment: Alignment.center,
                ),
                Positioned(
                  top: -15,
                  right: -15,
                  child: IconTheme(
                    data: const IconThemeData(size: 50),
                    child: IconButton(
                      onPressed: () async {
                        if (!await getIt<IFavorites>()
                            .checkIfExistsInFavorites(widget.book)) {
                          getIt<IFavorites>().addToFavorites(widget.book);
                          Snackbar.showSnackbar(
                              context, "Adicionado aos favoritos!");
                        } else {
                          getIt<IFavorites>().removeFromFavorites(widget.book);
                          Snackbar.showSnackbar(
                              context, "Removido dos favoritos!");
                        }
                      },
                      icon: Icon(
                        Icons.bookmark_rounded,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            widget.book.title,
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
            widget.book.author,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
