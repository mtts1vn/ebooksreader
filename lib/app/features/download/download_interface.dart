import 'package:ebooksreader/app/features/download/download_status.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class IDownload {
  Future<Result<DownloadStatusSuccess, DownloadStatusError>> downloadAndSave(
    String fileName,
    String fileExtension,
    String fileUrl,
  ); //return the file path
}
