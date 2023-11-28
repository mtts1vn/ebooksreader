// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ebooksreader/app/features/download/download_interface.dart';
import 'package:ebooksreader/app/features/download/download_status.dart';
import 'package:multiple_result/multiple_result.dart';

class DownloadFileUsecase {
  IDownload repository;

  Future<Result<DownloadStatusSuccess, DownloadStatusError>> downloadAndSave(
    String fileName,
    String fileExtension,
    String fileUrl,
  ) async {
    Result<DownloadStatusSuccess, DownloadStatusError> result =
        await repository.downloadAndSave(fileName, fileExtension, fileUrl);

    print("Result download: $result");

    return result.when(
      (success) => Result.success(success),
      (error) => Result.error(error),
    );
  }

  DownloadFileUsecase({
    required this.repository,
  });
}
