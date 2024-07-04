import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/widgets/document/document_item.dart';
import 'package:frontend_flutter/widgets/document/upload_card.dart';
import 'package:frontend_flutter/models/document_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';
import 'package:frontend_flutter/widgets/skeleton/document_grid_skeleton.dart';

class DocumentScreen extends StatelessWidget {
  final Future<List<Document>> documentsFuture;

  const DocumentScreen({required this.documentsFuture, super.key});

  void _uploadDocument() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyleConfig.primaryBackgroundColor,
      appBar: const CustomAppBar(title: 'Documents'),
      body: Center(
        child: FutureBuilder<List<Document>>(
          future: documentsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const DocumentGridSkeleton();
            } else if (snapshot.hasError) {
              return const Text('Error');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return _buildUploadSection(context);
            } else {
              return _buildDocumentsMasonryGrid(snapshot.data!);
            }
          },
        ),
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
          width: 160,
          child: ElevatedButton(
            onPressed: _uploadDocument,
            style: AppStyleConfig.secondaryButtonStyle,
            child: const Text("Upload"),
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentsMasonryGrid(List<Document> data) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        itemCount: data.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index < data.length) {
            return DocumentItem(document: data[index]);
          } else {
            return const UploadCard();
          }
        },
      ),
    );
  }
}
