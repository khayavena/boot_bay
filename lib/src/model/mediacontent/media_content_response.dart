class MediaContentResponse {
  String _fileName;
  String _fileDownloadUri;
  String _contentType;
  int _size;

  MediaContentResponse(
      {required String fileName,
      required String fileDownloadUri,
      required String contentType,
      required int size})
      : _fileName = fileName,
        _fileDownloadUri = fileDownloadUri,
        _contentType = contentType,
        _size = size;

  MediaContentResponse.fromJson(dynamic json)
      : _fileName = json['fileName'],
        _fileDownloadUri = json['fileDownloadUri'],
        _contentType = json['contentType'],
        _size = json['size'];

  String get fileName => _fileName;

  int get size => _size;

  String get contentType => _contentType;

  String get fileDownloadUri => _fileDownloadUri;
}
