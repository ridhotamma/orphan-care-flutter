import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/models/document_model.dart';

class DocumentItem extends StatelessWidget {
  final Document document;

  const DocumentItem({required this.document, super.key});

  @override
  Widget build(BuildContext context) {
    IconData iconData =
        document.type == 'pdf' ? Icons.picture_as_pdf : Icons.image;

    return Card(
      color: AppStyleConfig.primaryBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: InkWell(
        onTap: () {
          // Implement onTap functionality for document item
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData, size: 50),
              const SizedBox(height: 10),
              Text(
                document.name,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
