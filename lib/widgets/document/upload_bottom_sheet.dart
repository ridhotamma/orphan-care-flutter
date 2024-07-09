import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/events/event_bus.dart';
import 'package:frontend_flutter/events/events.dart';
import 'package:frontend_flutter/models/document_model.dart';
import 'package:frontend_flutter/providers/auth_provider.dart';
import 'package:frontend_flutter/services/document_service.dart';
import 'package:frontend_flutter/services/upload_service.dart';
import 'package:frontend_flutter/utils/response_handler_util.dart';
import 'package:frontend_flutter/widgets/input/required_text_form_field.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class UploadBottomSheet extends StatefulWidget {
  final String userId;

  const UploadBottomSheet({
    super.key,
    required this.userId,
  });

  @override
  State<UploadBottomSheet> createState() => _UploadBottomSheetState();
}

class _UploadBottomSheetState extends State<UploadBottomSheet> {
  String? _fileUrl;
  String? _fileName;
  String? _fileType;

  DocumentType? _selectedDocumentType;

  List<DocumentType> _fileTypes = [];

  bool _isUploading = false;
  bool _isSubmitting = false;

  final TextEditingController _fileNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    _fetchFileTypes();
    super.initState();
  }

  Future<void> _fetchFileTypes() async {
    await DocumentService(context: context).fetchDocumentTypes().then((data) {
      setState(() {
        _fileTypes = data;
      });
    }).onError(
      (error, stackTrace) {
        ResponseHandlerUtils.onSubmitFailed(context, error.toString());
      },
    );
  }

  Future<void> _onSubmit() async {
    if (_formKey.currentState?.validate() == true) {
      setState(() {
        _isSubmitting = true;
      });

      try {
        String userId =
            Provider.of<AuthProvider>(context, listen: false).userId ?? '';

        final data = DocumentRequest(
          name: _fileNameController.text,
          documentTypeId: _selectedDocumentType!.id,
          url: _fileUrl!,
        ).toJson();

        await DocumentService(context: context)
            .createUserDocument(userId, data)
            .then(
          (data) {
            if (mounted) {
              Navigator.of(context).pop();
              ResponseHandlerUtils.onSubmitSuccess(
                  context, 'Document created succesfuly');
            }
          },
        );
      } catch (e) {
        if (mounted) {
          ResponseHandlerUtils.onSubmitFailed(context, e.toString());
        }
      } finally {
        setState(() {
          _isSubmitting = false;
        });
        eventBus.fire(DocumentChangedEvent());
      }
    }
  }

  Future<void> _pickFile() async {
    try {
      setState(() {
        _fileType = null;
        _fileUrl = null;
        _fileName = null;
      });

      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'gif', 'webp', 'svg'],
        dialogTitle: 'Pick file from directory',
      );

      if (result != null) {
        final fileName = result.files.single.name;
        final fileExtension = result.files.single.extension?.toLowerCase();
        final fileBytes = result.files.single.bytes;

        setState(() {
          _fileName = fileName;
          _fileNameController.text = fileName;
          _fileType = fileExtension;
          _isUploading = true;
        });

        if (mounted) {
          if (kIsWeb && fileBytes != null) {
            // Use file bytes for web
            UploadService(context: context)
                .uploadFileBytes(fileBytes, fileName)
                .then((data) {
              setState(() {
                _fileUrl = data['url'];
              });
            }).catchError((error) {
              ResponseHandlerUtils.onSubmitFailed(context, error.toString());
            });
          } else if (result.files.single.path != null) {
            // Use file path for mobile
            UploadService(context: context)
                .uploadFile(result.files.single.path!)
                .then((data) {
              setState(() {
                _fileUrl = data['url'];
              });
            }).catchError((error) {
              ResponseHandlerUtils.onSubmitFailed(context, error.toString());
            });
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ResponseHandlerUtils.onSubmitFailed(context, e.toString());
      }
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Material(
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
                          child: _fileUrl != null &&
                                  _fileType != null &&
                                  _fileName != null
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
                              "Upload File",
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
                                  if (value == null || value.isEmpty) {
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
                                  setState(() {
                                    _selectedDocumentType = value;
                                  });
                                },
                                popupProps: const PopupProps.menu(
                                  constraints: BoxConstraints(maxHeight: 150),
                                ),
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
                        onPressed: () =>
                            _isSubmitting ? null : Navigator.of(context).pop(),
                        style: AppStyleConfig.defaultButtonStyle,
                        child: _isSubmitting
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: AppStyleConfig.accentColor,
                                  strokeWidth: 2.0,
                                ),
                              )
                            : const Text("Cancel"),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _onSubmit(),
                        style: AppStyleConfig.secondaryButtonStyle,
                        child: _isSubmitting
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: AppStyleConfig.accentColor,
                                  strokeWidth: 2.0,
                                ),
                              )
                            : const Text("Submit"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
      'webp',
      'svg'
    ];
    final List<String> pdfExtensions = ['pdf'];

    if (_fileType != null && imageExtensions.contains(_fileType)) {
      return Image.network(
        _fileUrl!,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } else if (_fileType != null &&
        pdfExtensions.contains(_fileType) &&
        !kIsWeb) {
      return _buildPdfViewer();
    } else {
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
      width: double.infinity,
      height: 400,
      child: SfPdfViewer.network(
        key: _pdfViewerKey,
        _fileUrl!,
      ),
    );
  }
}
