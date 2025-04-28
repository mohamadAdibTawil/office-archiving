import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:office_archiving/cubit/item_section_cubit/item_section_cubit.dart';
import 'package:office_archiving/functions/show_snack_bar.dart';
import 'package:permission_handler/permission_handler.dart';

void addItemFromMemoryStorage(
    BuildContext context, int idSection, ItemSectionCubit itemCubit) async {
  try {
    var storageStatus = await Permission.storage.status;
    if (!storageStatus.isGranted) {
      storageStatus = await Permission.storage.request();
      if (!storageStatus.isGranted) {
        showSnackBar(context, 'يجب منح صلاحية التخزين لاختيار الملف');
        return;
      }
    }
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      log('|| addItemFromMemoryStorage ||result $result ');
      final filePath = result.files.single.path!;
      log('|| addItemFromMemoryStorage ||filePath $filePath ');

      final fileNameWithExtension = filePath.split('/').last; // name.mp4
      final fileName = fileNameWithExtension.split('.').first; // name
      log('|| addItemFromMemoryStorage ||fileName $fileName ');

      final fileType = fileNameWithExtension.split('.').last; // mp4
      log('|| addItemFromMemoryStorage ||fileType $fileType ');
      itemCubit.addItem(fileName, filePath, fileType, idSection);
    } else {
      showSnackBar(context, 'No file selected');
    }
  } catch (e) {
    // Handle exceptions
    showSnackBar(context, 'Error: $e');
  }
}
