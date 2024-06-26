class Document {
  final String name;
  final String type;
  final String url;

  Document({
    required this.name,
    required this.type,
    required this.url,
  });

  Map<String, dynamic> toJson() => {'name': name, 'type': type, 'url': url};
}
