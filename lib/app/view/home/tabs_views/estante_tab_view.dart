import 'package:ebooksreader/app/api/api_class_status.dart';
import 'package:ebooksreader/app/api/http_impl/api_http_impl.dart';
import 'package:ebooksreader/app/api/usecase/get_all_books_usecase.dart';
import 'package:ebooksreader/app/model/book_model.dart';
import 'package:ebooksreader/app/view/custom_widgets/book_item_list_widget.dart';
import 'package:ebooksreader/app/view/custom_widgets/error_popup_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multiple_result/multiple_result.dart';

class EstanteTabView extends StatefulWidget {
  const EstanteTabView({super.key});

  @override
  State<EstanteTabView> createState() => _EstanteTabViewState();
}

class _EstanteTabViewState extends State<EstanteTabView>
    with AutomaticKeepAliveClientMixin<EstanteTabView> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
        future: GetAllBooks(repository: BookApiHttpImpl()).fetchAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is Success) {
              return showEstante(snapshot);
            } else {
              return ErrorPopup(
                errorMessage: "Ocorreu algum problema, tente novamente ;)",
                onRetry: () {
                  setState(() {});
                },
              );
            }
          } else if (snapshot.hasError) {
            if (kDebugMode) {
              print("erro: ${snapshot.error}");
            }

            return ErrorPopup(
              errorMessage: "Não foi possível carregar os livros",
              onRetry: () {
                setState(() {});
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget showEstante(
      AsyncSnapshot<Result<List<Book>, ApiStatusError>> snapshot) {
    List<Book>? booksList = snapshot.data?.tryGetSuccess();

    if (booksList != null && booksList.isNotEmpty) {
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

  @override
  bool get wantKeepAlive => true;
}
