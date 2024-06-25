import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/widgets/document/document_item.dart';
import 'package:frontend_flutter/widgets/document/upload_card.dart';
import 'package:frontend_flutter/models/document_model.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key});

  @override
  DocumentScreenState createState() => DocumentScreenState();
}

class DocumentScreenState extends State<DocumentScreen> {
  final List<Document> documents = [
    Document(
        name: "Kartu Keluarga.pdf",
        type: 'pdf',
        url: 'https://example.com/example1.pdf'),
    Document(
        name: "Akta Kelahiran.pdf",
        type: 'pdf',
        url: 'https://example.com/example1.pdf'),
    Document(
        name: "Surat Tanah.png",
        type: 'image',
        url: 'https://example.com/example1.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Documents',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppStyleConfig.secondaryColor,
      ),
      body: Center(
        child: documents.isEmpty
            ? _buildUploadSection(context)
            : _buildDocumentsGrid(),
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
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
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

  Widget _buildDocumentsGrid() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
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
