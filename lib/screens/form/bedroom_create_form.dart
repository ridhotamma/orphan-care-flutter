import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/events/event_bus.dart';
import 'package:frontend_flutter/events/events.dart';
import 'package:frontend_flutter/models/bedroom_model.dart';
import 'package:frontend_flutter/services/bedroom_service.dart';
import 'package:frontend_flutter/widgets/input/required_dropdown_button_form_field.dart';
import 'package:frontend_flutter/widgets/input/required_text_form_field.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';

class BedroomCreateForm extends StatefulWidget {
  const BedroomCreateForm({super.key});

  @override
  State<BedroomCreateForm> createState() => _BedroomCreateFormState();
}

class _BedroomCreateFormState extends State<BedroomCreateForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  List<DropdownMenuItem<String>> _bedRoomTypeItems = [];
  String? _selectedBedRoomTypeId;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _fetchBedRoomTypes();
  }

  Future<void> _fetchBedRoomTypes() async {
    final bedRoomTypes =
        await BedroomService(context: context).fetchBedRoomTypes();

    if (mounted) {
      setState(() {
        _bedRoomTypeItems = bedRoomTypes
            .map(
              (bedRoomType) => DropdownMenuItem(
                value: bedRoomType.id,
                child: Text(bedRoomType.name!),
              ),
            )
            .toList();
      });
    }
  }

  void _onSubmit() async {
    if (_formKey.currentState?.validate() == true) {
      setState(() {
        isSubmitting = true;
      });
      try {
        BedRoomInput bedRoomInput = BedRoomInput(
          name: _nameController.text,
          bedRoomTypeId: _selectedBedRoomTypeId!,
        );

        await BedroomService(context: context)
            .createBedRoom(bedRoomInput.toJson())
            .then(
          (data) {
            onSubmitSuccess('Bedroom created successfully');
            eventBus.fire(DataMasterCreatedEvent());
          },
        );
      } catch (e) {
        onSubmitFailed(e.toString());
      } finally {
        setState(() {
          isSubmitting = false;
        });
      }
    }
  }

  void onSubmitFailed(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppStyleConfig.errorColor,
        content: Text(
          errorMessage,
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void onSubmitSuccess(String successMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppStyleConfig.successColor,
        content: Text(
          successMessage,
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyleConfig.primaryBackgroundColor,
      appBar: const CustomAppBar(
        title: "Create Bedroom Form",
        automaticallyImplyLeading: true,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [Expanded(child: _buildForm()), _buildControls()],
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            RequiredTextFormField(
              controller: _nameController,
              hintText: 'Bedroom Name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the bedroom name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0),
            RequiredDropdownButtonFormField(
              value: _selectedBedRoomTypeId,
              hintText: 'Bed Room Type',
              onChanged: (value) {
                setState(() {
                  _selectedBedRoomTypeId = value;
                });
              },
              items: _bedRoomTypeItems,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: ElevatedButton(
              onPressed: isSubmitting ? null : _onSubmit,
              style: AppStyleConfig.secondaryButtonStyle,
              child: isSubmitting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.0,
                      ),
                    )
                  : const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
