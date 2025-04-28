import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:office_archiving/functions/show_snack_bar.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart'; 
Future<void> openFile(
    {required String pathFile, required BuildContext context}) async {

       var storageStatus = await Permission.storage.status;
  if (!storageStatus.isGranted) {
    storageStatus = await Permission.storage.request();
    if (!storageStatus.isGranted) {
      showSnackBar(context, 'يجب منح صلاحية التخزين لفتح الملف');
      return;
    }
  }
  OpenResult result = await OpenFile.open(pathFile);

  if (result.type == ResultType.done) {
    log('openFile opened successfully');
  } else {
    showSnackBar(context, 'wrong in open file');
  }
}
