// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebooksreader/app/features/book/book_downloader_manager.dart';
import 'package:ebooksreader/app/features/download/http_download_file.dart';
import 'package:ebooksreader/app/features/favorites/favorites_interface.dart';
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
                        } else {
                          getIt<IFavorites>().removeFromFavorites(widget.book);
                        }

                        setState(() {});
                      },
                      icon: FutureBuilder<bool>(
                        future: getIt<IFavorites>()
                            .checkIfExistsInFavorites(widget.book),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Icon(
                              Icons.bookmark_rounded,
                              color: snapshot.data ?? false
                                  ? Colors.red
                                  : Colors.grey[700],
                            );
                          } else {
                            return Container();
                          }
                        },
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
