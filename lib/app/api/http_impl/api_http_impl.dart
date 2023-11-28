import 'dart:convert';

import 'package:ebooksreader/app/api/api_class_status.dart';
import 'package:ebooksreader/app/api/api_interface.dart';
import 'package:http/http.dart';
import 'package:multiple_result/multiple_result.dart';

class BookApiHttpImpl implements IBookApi {
  String _apiBooksUrl = "https://escribo.com/books.json";

  @override
  Future<Result<ApiStatusSuccess, ApiStatusError>> getAllBooks() async {
    Response requestResponse = await get(
      Uri.parse(_apiBooksUrl),
      headers: {"content-type": "application/json; charset=utf-8"},
    );

    if (requestResponse.statusCode == 200) {
      List jsonListData = jsonDecode(
        const Utf8Decoder().convert(requestResponse.bodyBytes),
      );

      return Result.success(ApiStatusSuccess(data: jsonListData));
    } else {
      return Result.error(ApiStatusError(message: "Ops, algo deu errado :("));
    }
  }
}
