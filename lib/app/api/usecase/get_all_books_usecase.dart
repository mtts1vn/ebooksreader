// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ebooksreader/app/api/api_class_status.dart';
import 'package:ebooksreader/app/api/api_interface.dart';
import 'package:ebooksreader/app/model/book_model.dart';
import 'package:multiple_result/multiple_result.dart';

class GetAllBooks {
  IBookApi repository;

  Future<Result<List<Book>, ApiStatusError>> fetchAll() async {
    Result<ApiStatusSuccess, ApiStatusError> result =
        await repository.getAllBooks();

    return result.when(
      (success) => Result.success(
        success.data
            .map(
              (e) => Book(
                id: int.parse(e["id"].toString()),
                title: e["title"].toString(),
                author: e["author"].toString(),
                coverUrl: e["cover_url"].toString(),
                downloadUrl: e["download_url"].toString(),
              ),
            )
            .toList(),
      ),
      (error) => Result.error(
        ApiStatusError(message: "Ops, algo deu errado, Tente novamente!"),
      ),
    );
  }

  GetAllBooks({
    required this.repository,
  });
}
