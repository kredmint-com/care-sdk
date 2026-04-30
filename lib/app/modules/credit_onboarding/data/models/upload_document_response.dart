class UploadDocumentResponse {
  Document? payload;
  num? sum;
  num? timestamp;

  UploadDocumentResponse({this.payload, this.sum, this.timestamp});

  UploadDocumentResponse.fromJson(Map<String, dynamic> json) {
    payload =
        json['payload'] != null ? Document.fromJson(json['payload']) : null;
    sum = json['sum'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (payload != null) {
      data['payload'] = payload!.toJson();
    }
    data['sum'] = sum;
    data['timestamp'] = timestamp;
    return data;
  }
}

class Document {
  String? id;
  num? creationDate;
  num? lastModifiedDate;
  String? url;
  String? userId;
  String? name;
  String? relativeUrl;
  String? documentType;
  num? urlExpiryDate;
  bool? active;
  num? seqPrefixLength;

  Document({
    this.id,
    this.creationDate,
    this.lastModifiedDate,
    this.url,
    this.userId,
    this.name,
    this.relativeUrl,
    this.documentType,
    this.urlExpiryDate,
    this.active,
    this.seqPrefixLength,
  });

  Document.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creationDate = json['creationDate'];
    lastModifiedDate = json['lastModifiedDate'];
    url = json['url'];
    userId = json['userId'];
    name = json['name'];
    relativeUrl = json['relativeUrl'];
    documentType = json['documentType'];
    urlExpiryDate = json['urlExpiryDate'];
    active = json['active'];
    seqPrefixLength = json['seqPrefixLength'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['creationDate'] = creationDate;
    data['lastModifiedDate'] = lastModifiedDate;
    data['url'] = url;
    data['userId'] = userId;
    data['name'] = name;
    data['relativeUrl'] = relativeUrl;
    data['documentType'] = documentType;
    data['urlExpiryDate'] = urlExpiryDate;
    data['active'] = active;
    data['seqPrefixLength'] = seqPrefixLength;
    return data;
  }
}
