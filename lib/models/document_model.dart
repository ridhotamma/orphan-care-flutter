class Document {
  final String id;
  final String name;
  final String url;
  final DocumentType documentType;

  Document({
    required this.id,
    required this.name,
    required this.documentType,
    required this.url,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'],
      name: json['name'],
      documentType: DocumentType.fromJson(json['documentType']),
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'documentType': documentType,
        'url': url,
      };
}

class DocumentType {
  final String id;
  final String type;
  final String name;

  DocumentType({required this.id, required this.name, required this.type});

  factory DocumentType.fromJson(Map<String, dynamic> json) {
    return DocumentType(
      id: json['id'],
      name: json['name'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'id': id,
      };
}
