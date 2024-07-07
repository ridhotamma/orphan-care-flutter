import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/document_model.dart';

class DocumentItem extends StatelessWidget {
  final Document document;
  final VoidCallback onTap;

  const DocumentItem({
    required this.document,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final fileType = document.url.split('.').last;
    IconData iconData = fileType == 'pdf' ? Icons.picture_as_pdf : Icons.image;
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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(iconData, size: 50),
                const SizedBox(height: 10),
                Text(
                  document.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
