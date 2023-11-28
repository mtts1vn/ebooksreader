// ignore_for_file: public_member_api_docs, sort_constructors_first
class ApiStatusSuccess {
  List data;

  ApiStatusSuccess({
    required this.data,
  });
}

class ApiStatusError {
  String message;

  ApiStatusError({
    required this.message,
  });
}
