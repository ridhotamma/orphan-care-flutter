import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/document_model.dart';

class DocumentItem extends StatelessWidget {
  final Document document;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  DocumentItem({
    required this.document,
    required this.onTap,
    this.onLongPress,
    super.key,
  });

  final List<String> imageExtensions = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'webp',
    'svg'
  ];

  Widget _buildItem(String fileType) {
    if (fileType == 'pdf') {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.picture_as_pdf, size: 50),
          const SizedBox(height: 10),
          Text(
            document.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      );
    } else if (imageExtensions.contains(fileType)) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              document.url,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            document.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(Icons.image, size: 50),
          const SizedBox(height: 10),
          Text(
            document.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final fileType = document.url.split('.').last;
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 200, maxHeight: 200),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: _buildItem(fileType),
          ),
        ),
      ),
    );
  }
}
