import 'package:ebooksreader/app/api/api_class_status.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class IBookApi {
  Future<Result<ApiStatusSuccess, ApiStatusError>> getAllBooks();
}
