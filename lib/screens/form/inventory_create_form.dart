import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/events/event_bus.dart';
import 'package:frontend_flutter/events/events.dart';
import 'package:frontend_flutter/models/inventory_model.dart';
import 'package:frontend_flutter/services/inventory_service.dart';
import 'package:frontend_flutter/widgets/input/required_dropdown_button_form_field.dart';
import 'package:frontend_flutter/widgets/input/required_text_form_field.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';
import 'package:frontend_flutter/widgets/input/counter_input.dart';

class InventoryCreateForm extends StatefulWidget {
  const InventoryCreateForm({super.key});

  @override
  State<InventoryCreateForm> createState() => _InventoryCreateFormState();
}

class _InventoryCreateFormState extends State<InventoryCreateForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');

  late InventoryService _inventoryService;

  List<DropdownMenuItem<String>> _inventoryTypeItems = [];
  String? _selectedInventoryTypeId;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _inventoryService = InventoryService(context);
    _fetchInventoryTypes();
  }

  Future<void> _fetchInventoryTypes() async {
    final inventoryTypes = await _inventoryService.fetchInventoryTypes();

    if (mounted) {
      setState(() {
        _inventoryTypeItems = inventoryTypes
            .map(
              (inventoryType) => DropdownMenuItem(
                value: inventoryType.id,
                child: Text(inventoryType.name),
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
        int quantity = int.tryParse(_quantityController.text) ?? 1;
        InventoryInput inventoryInput = InventoryInput(
          name: _nameController.text,
          inventoryTypeId: _selectedInventoryTypeId!,
          quantity: quantity,
        );
        await _inventoryService.createInventory(inventoryInput.toJson());
        onSubmitSuccess('inventory created successfully');
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
    eventBus.fire(DataMasterCreatedEvent());
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyleConfig.primaryBackgroundColor,
      appBar: const CustomAppBar(
        title: "Create Inventory Form",
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
              hintText: 'Inventory Name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the inventory name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0),
            RequiredDropdownButtonFormField(
              value: _selectedInventoryTypeId,
              hintText: 'Inventory Type',
              onChanged: (value) {
                setState(() {
                  _selectedInventoryTypeId = value;
                });
              },
              items: _inventoryTypeItems,
            ),
            const SizedBox(height: 20.0),
            CounterInput(
              controller: _quantityController,
              hintText: 'Quantity',
            ),
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
