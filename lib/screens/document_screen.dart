import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/widgets/document/document_item.dart';
import 'package:frontend_flutter/widgets/document/upload_card.dart';
import 'package:frontend_flutter/models/document_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key});

  @override
  DocumentScreenState createState() => DocumentScreenState();
}

class DocumentScreenState extends State<DocumentScreen> {
  final List<Document> documents = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyleConfig.primaryBackgroundColor,
      appBar: const CustomAppBar(title: 'Documents'),
      body: Center(
        child: documents.isEmpty
            ? _buildUploadSection(context)
            : _buildDocumentsMasonryGrid(),
      ),
    );
  }

  Widget _buildUploadSection(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.cloud_upload, size: 100),
        const SizedBox(height: 20),
        const Text(
          'Upload your documents here',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: ElevatedButton(
            onPressed: _uploadDocument,
            style: AppStyleConfig.secondaryButtonStyle,
            child: const Text("Upload"),
          ),
        ),
      ],
    );
  }

  void _uploadDocument() {
    setState(() {
      documents.add(Document(
        name: "example2.pdf",
        type: 'pdf',
        url: 'https://example.com/example2.pdf',
      ));
    });
  }

  Widget _buildDocumentsMasonryGrid() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: documents.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index < documents.length) {
            return DocumentItem(document: documents[index]);
          } else {
            return const UploadCard();
          }
        },
      ),
    );
  }
}
