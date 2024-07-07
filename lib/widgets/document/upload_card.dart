import 'package:flutter/material.dart';
import 'package:frontend_flutter/widgets/document/upload_bottom_sheet.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class UploadCard extends StatelessWidget {
  const UploadCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: InkWell(
        onTap: () {
          showCupertinoModalBottomSheet(
            context: context,
            builder: (context) => const UploadBottomSheet(),
            expand: true,
          );
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
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
