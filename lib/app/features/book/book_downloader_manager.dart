// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'dart:io';

import 'package:ebooksreader/app/features/book/open_book_to_read.dart';
import 'package:flutter/material.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:ebooksreader/app/features/download/download_interface.dart';
import 'package:ebooksreader/app/features/download/download_status.dart';
import 'package:ebooksreader/app/features/snackbar/snakbar.dart';
import 'package:ebooksreader/app/features/download/usecase/download_file_usecase.dart';
import 'package:ebooksreader/app/model/book_model.dart';
import 'package:path_provider/path_provider.dart';

class FileExistenceChecker {
  Future<bool> checkIfFileExists(String filePath) async {
    return File(filePath).existsSync();
  }
}

class BookDownloadManager {
  final IDownload repositoryDownload;

  BookDownloadManager({
    required this.repositoryDownload,
  });

  Future<void> downloadAndSaveBook(
    BuildContext context,
    Book book,
    String fileExtension,
  ) async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String filePath =
        '${appDocumentsDirectory.path}/${book.title.replaceAll(" ", "_").toLowerCase()}.$fileExtension';

    FileExistenceChecker fileExistenceChecker = FileExistenceChecker();
    if (!await fileExistenceChecker.checkIfFileExists(filePath)) {
      Snackbar.showSnackbar(context, "Baixando...");

      Result<DownloadStatusSuccess, DownloadStatusError> result =
          await DownloadFileUsecase(repository: repositoryDownload)
              .downloadAndSave(book.title, fileExtension, book.downloadUrl);

      if (result is Success) {
        OPenBookToRead.openBook(context, filePath);
      } else {
        Snackbar.showSnackbar(context, "Não foi possível baixar");
      }
    } else {
      Snackbar.showSnackbar(context, "Abrindo Livro...");
      OPenBookToRead.openBook(context, filePath);
    }
  }
}
