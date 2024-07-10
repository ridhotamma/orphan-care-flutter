import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/events/event_bus.dart';
import 'package:frontend_flutter/events/events.dart';
import 'package:frontend_flutter/providers/auth_provider.dart';
import 'package:frontend_flutter/services/document_service.dart';
import 'package:frontend_flutter/utils/response_handler_util.dart';
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

class DocumentScreen extends StatefulWidget {
  final Future<List<Document>> documentsFuture;

  const DocumentScreen({
    required this.documentsFuture,
    super.key,
  });

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  bool isDeleting = false;

  @override
  Widget build(BuildContext context) {
    final String userId =
        Provider.of<AuthProvider>(context, listen: false).userId ?? '';

    return Scaffold(
      backgroundColor: AppStyleConfig.primaryBackgroundColor,
      appBar: const CustomAppBar(title: 'Documents'),
      body: FutureBuilder<List<Document>>(
        future: widget.documentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const DocumentGridSkeleton();
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error'));
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
              onPressed: () => _showUploadBottomSheet(context, userId),
              style: AppStyleConfig.secondaryButtonStyle,
              child: const Text("Upload"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsMasonryGrid(List<Document> documents, String userId) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          itemCount: documents.length + 1,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if (index < documents.length) {
              return DocumentItem(
                document: documents[index],
                onLongPress: () =>
                    _showDeleteConfirmation(context, documents[index]),
                onTap: () => _showDocumentPreview(context, documents[index]),
              );
            } else {
              return UploadCard(
                onTap: () => _showUploadBottomSheet(context, userId),
              );
            }
          },
        ),
      ),
    );
  }

  void _showUploadBottomSheet(BuildContext context, String userId) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => UploadBottomSheet(userId: userId),
      expand: true,
    );
  }

  void _showDeleteConfirmation(BuildContext context, Document document) {
    final String userId =
        Provider.of<AuthProvider>(context, listen: false).userId ?? '';

    void deleteDocument() async {
      setState(() {
        isDeleting = true;
      });

      try {
        await DocumentService(context: context)
            .deleteUserDocument(userId, document.id);

        if (context.mounted) {
          ResponseHandlerUtils.onSubmitSuccess(
              context, 'Document deleted successfully');
          eventBus.fire(DocumentChangedEvent());
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (context.mounted) {
          ResponseHandlerUtils.onSubmitFailed(context, e.toString());
        }
      } finally {
        setState(() {
          isDeleting = false;
        });
      }
    }

    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      builder: (context) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(
                    'Delete ${document.name}?',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: const Text('Deleted data cannot be restored'),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        deleteDocument();
                      },
                      child: const Text(
                        'Yes, delete',
                        style: TextStyle(color: AppStyleConfig.errorColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDocumentPreview(BuildContext context, Document document) {
    final fileType = document.url.split('.').last;
    final List<String> imageExtensions = [
      'jpg',
      'jpeg',
      'png',
      'webp',
      'gif',
      'bmp',
      'tiff',
      'heic'
    ];

    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) {
        if (imageExtensions.contains(fileType)) {
          return ImagePreview(imageUrl: document.url);
        } else if (fileType == 'pdf') {
          return DocumentPreview(documentUrl: document.url);
        } else {
          return const SafeArea(
            child: Scaffold(
              appBar: CustomAppBar(
                title: 'Preview',
                automaticallyImplyLeading: true,
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.error, size: 45),
                    SizedBox(height: 10),
                    Text(
                      'Preview not available',
                      style: AppStyleConfig.headlineTextStyle,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'File not supported',
                      style: AppStyleConfig.bodyTextStyle,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
