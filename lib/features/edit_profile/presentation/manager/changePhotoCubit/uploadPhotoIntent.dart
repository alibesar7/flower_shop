import 'dart:io';

abstract class UploadPhotoIntent {}

class SelectPhotoIntent extends UploadPhotoIntent {
  final File photo;
  SelectPhotoIntent(this.photo);
}

class UploadSelectedPhotoIntent extends UploadPhotoIntent {
  final String token;
  UploadSelectedPhotoIntent(this.token);
}
