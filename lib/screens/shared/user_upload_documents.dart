import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/models/document_model.dart';
import 'package:frontend_flutter/services/document_service.dart';
import 'package:frontend_flutter/widgets/document/document_preview.dart';
import 'package:frontend_flutter/widgets/document/image_preview.dart';
import 'package:frontend_flutter/widgets/document/upload_bottom_sheet.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shimmer/shimmer.dart';

class UserUploadDocuments extends StatefulWidget {
  final String id;

  const UserUploadDocuments({
    super.key,
    required this.id,
  });

  @override
  State<UserUploadDocuments> createState() => _UserUploadDocumentsState();
}

class _UserUploadDocumentsState extends State<UserUploadDocuments> {
  late Future<List<Document>>? _documentFuture;

  void _fetchData() async {
    final documentFuture =
        DocumentService(context: context).fetchUserDocuments(widget.id);

    setState(() {
      _documentFuture = documentFuture;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void onDeleteSuccess(inventoryName) {
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppStyleConfig.successColor,
        content: Text(
          'Inventory $inventoryName deleted',
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  Future<bool?> _showDeleteConfirmationDialog(
      BuildContext context, String itemName) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Confirmation'),
          content: Text('Are you sure you want to delete $itemName?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showLoadingDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text('Deleting...'),
            ],
          ),
        );
      },
    );
  }

  void _showUploadBottomSheet(BuildContext context, String userId) async {
    final result = await showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => UploadBottomSheet(userId: userId),
      expand: true,
    );

    if (result == true) {
      _fetchData();
    }
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'Upload Documents',
          automaticallyImplyLeading: true,
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 100.0),
              child: FutureBuilder(
                future: _documentFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _buildDocumentsSkeleton();
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return _buildDocumentsEmptyState();
                  } else if (snapshot.hasError) {
                    return _buildDocumentsEmptyState();
                  } else {
                    return _buildDocumentsListView(snapshot.data!);
                  }
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton.icon(
                  onPressed: () => _showUploadBottomSheet(context, widget.id),
                  label: const Text('Upload Document'),
                  icon: const Icon(Icons.upload_file),
                  style: AppStyleConfig.secondaryButtonStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentsListView(List<Document> data) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final document = data[index];
        return Dismissible(
          key: Key(document.id.toString()),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          confirmDismiss: (direction) async {
            return await _showDeleteConfirmationDialog(context, document.name);
          },
          onDismissed: (direction) async {
            _showLoadingDialog(context);

            try {
              await DocumentService(context: context)
                  .deleteUserDocument(widget.id, document.id);
              setState(() {
                data.removeAt(index);
              });
            } finally {
              onDeleteSuccess(document.name);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.file_copy,
                  color: Colors.blue.shade900,
                ),
              ),
              title: Text(
                document.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(document.documentType.name),
              onTap: () {
                _showDocumentPreview(context, document);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildDocumentsSkeleton() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              tileColor: Colors.white,
              leading: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.file_copy,
                  color: Colors.grey.shade300,
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.grey.shade300,
                    height: 20.0,
                    width: 100.0,
                  ),
                  const SizedBox(
                      height: 8.0), // Spacing between title and subtitle
                  Container(
                    color: Colors.grey.shade300,
                    height: 20.0,
                    width: 150.0,
                  ),
                ],
              ),
              trailing:
                  Icon(Icons.arrow_forward_ios, color: Colors.grey.shade300),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDocumentsEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(
              Icons.file_copy,
              color: Colors.blue.shade900,
              size: 60.0,
            ),
          ),
          const SizedBox(height: 20.0),
          const Text(
            'There are no documents',
            style: AppStyleConfig.headlineMediumTextStyle,
          )
        ],
      ),
    );
  }
}
