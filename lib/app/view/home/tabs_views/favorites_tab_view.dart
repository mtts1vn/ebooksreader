import 'package:ebooksreader/app/features/favorites/favorites_interface.dart';
import 'package:ebooksreader/app/model/book_model.dart';
import 'package:ebooksreader/app/view/custom_widgets/book_item_list_widget.dart';
import 'package:ebooksreader/get_it/locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FavoritesTabView extends StatefulWidget {
  const FavoritesTabView({super.key});

  @override
  State<FavoritesTabView> createState() => _FavoritesTabViewState();
}

class _FavoritesTabViewState extends State<FavoritesTabView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getIt<IFavorites>().getAllFavorites(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return showEstante(snapshot.data as List<Book>);
          } else if (snapshot.hasError) {
            if (kDebugMode) {
              print("erro: ${snapshot.error}");
            }
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget showEstante(List<Book> booksList) {
    if (booksList.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: booksList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            mainAxisExtent: 200,
          ),
          itemBuilder: (context, position) {
            Book book = booksList[position];

            return BookItem(book: book);
          },
        ),
      );
    } else {
      return Container();
    }
  }
}
