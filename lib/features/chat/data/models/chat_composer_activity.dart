/// What the peer (or local user) is doing in the composer — WhatsApp-style.
enum ChatComposerActivity {
  none,
  typing,
  recording,
  sendingImage,
  sendingImages,
  sendingFile,
  sendingFiles;

  bool get isActive => this != ChatComposerActivity.none;

  /// Image/file upload status — can last longer than typing/recording.
  bool get isUpload =>
      this == ChatComposerActivity.sendingImage ||
      this == ChatComposerActivity.sendingImages ||
      this == ChatComposerActivity.sendingFile ||
      this == ChatComposerActivity.sendingFiles;

  /// Only text typing should play mechanical click sounds.
  bool get playsTypingSound => this == ChatComposerActivity.typing;

  String get apiValue => switch (this) {
        ChatComposerActivity.none => 'none',
        ChatComposerActivity.typing => 'typing',
        ChatComposerActivity.recording => 'recording',
        ChatComposerActivity.sendingImage => 'sending_image',
        ChatComposerActivity.sendingImages => 'sending_images',
        ChatComposerActivity.sendingFile => 'sending_file',
        ChatComposerActivity.sendingFiles => 'sending_files',
      };

  static ChatComposerActivity fromApi(dynamic raw) {
    final value = raw?.toString().trim().toLowerCase() ?? '';
    return switch (value) {
      'typing' || 'text' || 'user-typing' => ChatComposerActivity.typing,
      'recording' || 'record' || 'user-recording' || 'voice' =>
        ChatComposerActivity.recording,
      'sending_image' ||
      'sending_photo' ||
      'uploading_image' ||
      'uploading_photo' ||
      'image' =>
        ChatComposerActivity.sendingImage,
      'sending_images' ||
      'sending_photos' ||
      'uploading_images' ||
      'uploading_photos' ||
      'images' =>
        ChatComposerActivity.sendingImages,
      'sending_file' ||
      'sending_document' ||
      'uploading_file' ||
      'uploading_document' ||
      'file' ||
      'document' =>
        ChatComposerActivity.sendingFile,
      'sending_files' ||
      'sending_documents' ||
      'uploading_files' ||
      'uploading_documents' ||
      'files' ||
      'documents' =>
        ChatComposerActivity.sendingFiles,
      _ => ChatComposerActivity.none,
    };
  }

  static ChatComposerActivity sendingImagesForCount(int count) => count > 1
      ? ChatComposerActivity.sendingImages
      : ChatComposerActivity.sendingImage;

  static ChatComposerActivity sendingFilesForCount(int count) => count > 1
      ? ChatComposerActivity.sendingFiles
      : ChatComposerActivity.sendingFile;
}
