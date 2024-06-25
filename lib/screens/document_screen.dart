import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';

const IconData pdfIcon = Icons.picture_as_pdf;
const IconData imageIcon = Icons.image;

final List<String> documents = ["example1.pdf"];

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({super.key});

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
            ? Column(
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
                      onPressed: () {},
                      style: AppStyleConfig.secondaryButtonStyle,
                      child: const Text(
                        "Upload",
                      ),
                    ),
                  )
                ],
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: documents.length + 1, // +1 for upload card
                  itemBuilder: (BuildContext context, int index) {
                    if (index < documents.length) {
                      return DocumentItem(document: documents[index]);
                    } else {
                      return const UploadCard();
                    }
                  },
                ),
              ),
      ),
    );
  }
}

class DocumentItem extends StatelessWidget {
  final String document;

  const DocumentItem({required this.document, super.key});

  @override
  Widget build(BuildContext context) {
    // Determine file type based on extension (for demo purposes)
    IconData iconData = document.endsWith('.pdf') ? pdfIcon : imageIcon;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
            width: 1,
            color: Colors.grey,
            style: BorderStyle.solid), // Dashed border
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, size: 50),
            const SizedBox(height: 10),
            Text(
              document,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class UploadCard extends StatelessWidget {
  const UploadCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
            width: 1,
            color: Colors.grey,
            style: BorderStyle.solid), // Dashed border
      ),
      child: InkWell(
        onTap: () {},
        child: const Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cloud_upload, size: 50),
              SizedBox(height: 10),
              Text(
                'Upload',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
