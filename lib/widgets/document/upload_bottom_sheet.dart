import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/models/document_model.dart';
import 'package:frontend_flutter/services/document_service.dart';
import 'package:frontend_flutter/services/upload_service.dart';
import 'package:frontend_flutter/utils/response_handler_utils.dart';
import 'package:frontend_flutter/widgets/input/required_text_form_field.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class UploadBottomSheet extends StatefulWidget {
  const UploadBottomSheet({super.key});

  @override
  State<UploadBottomSheet> createState() => _UploadBottomSheetState();
}

class _UploadBottomSheetState extends State<UploadBottomSheet> {
  Uint8List? _fileBytes;
  String? _fileUrl;
  String? _fileName;
  String? _fileType;

  DocumentType? _selectedDocumentType;

  List<DocumentType> _fileTypes = [];

  bool _isUploading = false;
  bool _isSubmitting = false;

  final TextEditingController _fileNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _fetchFileTypes();
    super.initState();
  }

  Future<void> _fetchFileTypes() async {
    await DocumentService(context: context).fetchDocumentTypes().then((data) {
      _fileTypes = data;
    }).onError(
      (error, stackTrace) {
        ResponseHandlerUtils.onSubmitFailed(context, error.toString());
      },
    );
  }

  Future<void> _onSubmit() async {
    setState(() {
      _isSubmitting = true;
    });
    setState(() {
      _isSubmitting = false;
    });
  }

  Future<void> _pickFile() async {
    setState(() {
      _isUploading = true;
    });

    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final fileExtension = result.files.single.extension?.toLowerCase();

      setState(() {
        _fileBytes = result.files.single.bytes;
        _fileName = result.files.single.name;
        _fileNameController.text = _fileName ?? '';
        _fileType = fileExtension;
      });

      if (mounted) {
        await UploadService(context: context)
            .uploadFileBytes(_fileBytes!, _fileName!)
            .then(
          (data) {
            _fileUrl = data['url'];
          },
        ).catchError((error) {
          ResponseHandlerUtils.onSubmitFailed(context, error.toString());
        });
      }

      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Upload Document',
              style: AppStyleConfig.headlineTextStyle,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: _fileUrl != null
                          ? _buildUploadedItem()
                          : Container(
                              padding: const EdgeInsets.all(16.0),
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: _isUploading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: AppStyleConfig.accentColor,
                                      ),
                                    )
                                  : Icon(
                                      Icons.image,
                                      size: 100,
                                      color: Colors.grey[400],
                                    ),
                            ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => _pickFile(),
                        style: AppStyleConfig.primaryButtonStyle,
                        label: const Text(
                          "Upload Image",
                        ),
                        icon: const Icon(Icons.upload_file),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          RequiredTextFormField(
                            controller: _fileNameController,
                            validator: (value) {
                              if (value == null) {
                                return 'File name cannot be empty';
                              }
                              return null;
                            },
                            hintText: 'File name',
                          ),
                          const SizedBox(height: 20),
                          DropdownSearch<DocumentType>(
                            itemAsString: (item) => item.name,
                            items: _fileTypes,
                            validator: (value) {
                              if (value == null) {
                                return 'Please select file type';
                              }
                              return null;
                            },
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration:
                                  AppStyleConfig.inputDecoration.copyWith(
                                labelText: 'File Type *',
                                hintText: 'Select File Type',
                              ),
                            ),
                            selectedItem: _selectedDocumentType,
                            onChanged: (value) {
                              _selectedDocumentType = value;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: AppStyleConfig.defaultButtonStyle,
                    child: const Text("Cancel"),
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _onSubmit,
                    style: AppStyleConfig.secondaryButtonStyle,
                    child: _isSubmitting
                        ? const CircularProgressIndicator(
                            color: AppStyleConfig.accentColor,
                            strokeWidth: 2.0,
                          )
                        : const Text("Create Document"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadedItem() {
    final List<String> imageExtensions = [
      'jpg',
      'jpeg',
      'png',
      'gif',
      'bmp',
      'tiff',
      'tif',
      'webp',
      'svg',
      'ico',
      'heic'
    ];
    final List<String> pdfExtensions = ['pdf'];

    if (imageExtensions.contains(_fileType)) {
      return Image.network(
        _fileUrl!,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } else if (pdfExtensions.contains(_fileType)) {
      return _buildPdfViewer();
    } else {
      // For other document types, simply show the file name
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.description,
              size: 60,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              _fileName!,
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildPdfViewer() {
    return SizedBox(
      height: 400,
      child: FutureBuilder<File>(
        future: _downloadPdfFile(_fileUrl!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                  child: Text('Error loading PDF: ${snapshot.error}'));
            }
            return PDFView(
              filePath: snapshot.data?.path,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<File> _downloadPdfFile(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/temp.pdf');
    await file.writeAsBytes(bytes);
    return file;
  }
}
