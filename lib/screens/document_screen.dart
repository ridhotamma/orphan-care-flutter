import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/providers/auth_provider.dart';
import 'package:frontend_flutter/widgets/document/document_item.dart';
import 'package:frontend_flutter/widgets/document/document_preview.dart';
import 'package:frontend_flutter/widgets/document/image_preview.dart';
import 'package:frontend_flutter/widgets/document/upload_bottom_sheet.dart';
import 'package:frontend_flutter/widgets/document/upload_card.dart';
import 'package:frontend_flutter/models/document_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';
import 'package:frontend_flutter/widgets/skeleton/document_grid_skeleton.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class DocumentScreen extends StatelessWidget {
  final Future<List<Document>> documentsFuture;

  const DocumentScreen({
    required this.documentsFuture,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String userId =
        Provider.of<AuthProvider>(context, listen: false).userId ?? '';

    return Scaffold(
      backgroundColor: AppStyleConfig.primaryBackgroundColor,
      appBar: const CustomAppBar(title: 'Documents'),
      body: FutureBuilder<List<Document>>(
        future: documentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const DocumentGridSkeleton();
          } else if (snapshot.hasError) {
            return const Text('Error');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return _buildUploadSection(context, userId);
          } else {
            return _buildDocumentsMasonryGrid(snapshot.data!, userId);
          }
        },
      ),
    );
  }

  Widget _buildUploadSection(BuildContext context, String userId) {
    return Center(
      child: Column(
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
              onPressed: () {
                showCupertinoModalBottomSheet(
                  context: context,
                  builder: (context) => UploadBottomSheet(
                    userId: userId,
                  ),
                  expand: true,
                );
              },
              style: AppStyleConfig.secondaryButtonStyle,
              child: const Text("Upload"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsMasonryGrid(List<Document> data, String userId) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          itemCount: data.length + 1,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            if (index < data.length) {
              return DocumentItem(
                document: data[index],
                onTap: () {
                  final fileType = data[index].url.split('.').last;
                  final List<String> imageExtensions = ['jpg', 'jpeg', 'png'];
                  showCupertinoModalBottomSheet(
                    context: context,
                    builder: (context) {
                      if (imageExtensions.contains(fileType)) {
                        return ImagePreview(imageUrl: data[index].url);
                      } else if (fileType == 'pdf') {
                        return DocumentPreview(documentUrl: data[index].url);
                      } else {
                        return const Center(
                          child: Text('Preview not available'),
                        );
                      }
                    },
                  );
                },
              );
            } else {
              return UploadCard(
                onTap: () {
                  showCupertinoModalBottomSheet(
                    context: context,
                    builder: (context) => UploadBottomSheet(
                      userId: userId,
                    ),
                    expand: true,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
