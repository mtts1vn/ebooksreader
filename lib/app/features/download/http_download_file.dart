// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:ebooksreader/app/features/download/download_interface.dart';
import 'package:ebooksreader/app/features/download/download_status.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:path_provider/path_provider.dart';

class HttpDownloadFile implements IDownload {
  @override
  Future<Result<DownloadStatusSuccess, DownloadStatusError>> downloadAndSave(
    String fileName,
    String fileExtension,
    String fileUrl,
  ) async {
    try {
      Directory appDocumentsDirectory =
          await getApplicationDocumentsDirectory();
      String filePath =
          '${appDocumentsDirectory.path}/${fileName.replaceAll(" ", "_").toLowerCase()}.$fileExtension';

      Response response = await get(Uri.parse(fileUrl));
      File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      return Result.success(
        DownloadStatusSuccess(data: filePath),
      );
    } catch (e) {
      if (kDebugMode) {
        print("Exception HttpDownloadFile: ${e.toString()}");
      }

      return Result.error(
        DownloadStatusError(message: "Não foi possível baixar :("),
      );
    }
  }
}
