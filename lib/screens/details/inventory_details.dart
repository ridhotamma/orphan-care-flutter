import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/events/event_bus.dart';
import 'package:frontend_flutter/events/events.dart';
import 'package:frontend_flutter/models/inventory_model.dart';
import 'package:frontend_flutter/services/inventory_service.dart';
import 'package:frontend_flutter/widgets/input/counter_input.dart';
import 'package:frontend_flutter/widgets/input/required_dropdown_button_form_field.dart';
import 'package:frontend_flutter/widgets/input/required_text_form_field.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';

class InventoryDetails extends StatefulWidget {
  final String id;

  const InventoryDetails({super.key, required this.id});

  @override
  State<InventoryDetails> createState() => _InventoryDetailsState();
}

class _InventoryDetailsState extends State<InventoryDetails> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');

  late Future<Inventory> _inventoryFuture;

  List<DropdownMenuItem<String>> _inventoryTypeItems = [];
  String? _selectedInventoryTypeId;
  bool isSubmitting = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _fetchInventoryTypes();
  }

  void _fetchData() async {
    setState(() {
      _inventoryFuture =
          InventoryService(context).fetchInventoryById(widget.id);
    });

    _inventoryFuture.then((data) {
      _nameController.text = data.name;
      _quantityController.text = data.quantity.toString();
      _selectedInventoryTypeId = data.inventoryType!.id;
    });
  }

  Future<void> _fetchInventoryTypes() async {
    final inventoryTypes =
        await InventoryService(context).fetchInventoryTypes();

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

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _onSubmit() async {
    if (_formKey.currentState?.validate() == true) {
      try {
        setState(() {
          isSubmitting = true;
        });

        int quantity = int.tryParse(_quantityController.text) ?? 1;
        Map<String, dynamic> updatedInventory = Inventory(
          name: _nameController.text,
          quantity: quantity,
          inventoryTypeId: _selectedInventoryTypeId,
        ).toJson();

        await InventoryService(context)
            .updateInventory(widget.id, updatedInventory)
            .then((data) {
          onSubmitSuccess('${data.name} updated successfully');
          eventBus.fire(DataMasterCreatedEvent());
        });
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
          textColor: Colors.white,
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
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyleConfig.primaryBackgroundColor,
      appBar: const CustomAppBar(
        title: "Detail Inventory",
        automaticallyImplyLeading: true,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<Inventory>(
        future: _inventoryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return _isEditing
                ? Column(
                    children: [
                      Expanded(
                        child: _buildForm(context, snapshot.data!),
                      ),
                      _buildControls(context)
                    ],
                  )
                : _buildDetail(context, snapshot.data!);
          }
        },
      ),
      floatingActionButton: _isEditing
          ? null
          : FloatingActionButton(
              onPressed: _toggleEditMode,
              backgroundColor: AppStyleConfig.secondaryColor,
              foregroundColor: Colors.white,
              shape: const CircleBorder(),
              child: Icon(_isEditing ? Icons.check : Icons.edit_outlined),
            ),
    );
  }

  Widget _buildForm(BuildContext context, Inventory data) {
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

  Widget _buildDetail(BuildContext context, Inventory data) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailItem('Inventory Name', data.name),
          const SizedBox(height: 16.0),
          _buildDetailItem('Inventory Type', data.inventoryType!.name),
          const SizedBox(height: 16.0),
          _buildDetailItem('Quantity', data.quantity.toString()),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppStyleConfig.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: AppStyleConfig.primaryColor,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16.0,
              color: AppStyleConfig.secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: ElevatedButton(
              onPressed: isSubmitting ? null : _toggleEditMode,
              style: AppStyleConfig.defaultButtonStyle,
              child: isSubmitting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.0,
                      ),
                    )
                  : const Text('Cancel'),
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
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
