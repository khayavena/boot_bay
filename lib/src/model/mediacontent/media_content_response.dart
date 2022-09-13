class MediaContentResponse {
  String fileName;
  String fileDownloadUri;
  String contentType;
  int size;

  MediaContentResponse(
      {this.fileName = '',
      this.fileDownloadUri = '',
      this.contentType = '',
      this.size = 0});

  MediaContentResponse.fromJson(dynamic json)
      : fileName = json['fileName'],
        fileDownloadUri = json['fileDownloadUri'],
        contentType = json['contentType'],
        size = json['size'];
}
