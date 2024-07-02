import 'package:flutter/material.dart';

import 'package:frontend_flutter/widgets/input/required_text_form_field.dart';
import 'package:frontend_flutter/widgets/input/optional_text_form_field.dart';
import 'package:frontend_flutter/widgets/input/required_dropdown_button_form_field.dart';
import 'package:frontend_flutter/widgets/input/toggle_button.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/widgets/document/document_item.dart';
import 'package:frontend_flutter/widgets/document/upload_card.dart';
import 'package:frontend_flutter/models/document_model.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';
import 'package:frontend_flutter/widgets/shared/section_title.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CaretakerCreateForm extends StatefulWidget {
  const CaretakerCreateForm({super.key});

  @override
  State<CaretakerCreateForm> createState() => _CaretakerCreateFormState();
}

class _CaretakerCreateFormState extends State<CaretakerCreateForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _profileFormKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _birthPlaceController = TextEditingController();
  final _joinDateController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  final _guardianFullNameController = TextEditingController();
  String? _selectedBedRoom;
  String? _selectedFamilyRelation;

  final _addressFormKey = GlobalKey<FormState>();
  final _streetController = TextEditingController();
  final _urbanVillageController = TextEditingController();
  final _subdistrictController = TextEditingController();
  final _cityController = TextEditingController();
  final _provinceController = TextEditingController();
  final _postalCodeController = TextEditingController();

  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  int _currentStep = 0;

  final List<String> _steps = [
    'Basic Information',
    'Profile and Address',
    'Document',
  ];

  final List<Document> _documents = [];

  final List<bool> _selectedGenderToggle = [true, false, false];

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _birthdayController.dispose();
    _birthPlaceController.dispose();
    _joinDateController.dispose();
    _phoneNumberController.dispose();
    _guardianFullNameController.dispose();
    _streetController.dispose();
    _urbanVillageController.dispose();
    _subdistrictController.dispose();
    _cityController.dispose();
    _provinceController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  void _onStepContinue() {
    if (_currentStep == 0) {
      if (_formKey.currentState?.validate() == true) {
        setState(() {
          _currentStep += 1;
        });
      }
    } else if (_currentStep == 1) {
      if (_profileFormKey.currentState?.validate() == true &&
          _addressFormKey.currentState?.validate() == true) {
        setState(() {
          _currentStep += 1;
        });
      }
    } else {
      if (_currentStep < _steps.length - 1) {
        setState(() {
          _currentStep += 1;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Form Submitted')),
        );
      }
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = _dateFormat.format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyleConfig.primaryBackgroundColor,
      appBar: const CustomAppBar(
        title: 'Tambah Data Pengasuh',
        foregroundColor: Colors.white,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          _buildHorizontalStepper(),
          Expanded(
            child: IndexedStack(
              index: _currentStep,
              children: _steps.map((step) {
                switch (step) {
                  case 'Basic Information':
                    return _buildAccount();
                  case 'Profile and Address':
                    return _buildProfileAndAddress();
                  case 'Document':
                    return _buildDocument();
                  default:
                    return const SizedBox.shrink();
                }
              }).toList(),
            ),
          ),
          _buildControls(),
        ],
      ),
    );
  }

  Widget _buildHorizontalStepper() {
    double progressPercentage = (_currentStep + 1) / _steps.length;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _steps[_currentStep],
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
            Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: progressPercentage,
                  backgroundColor: Colors.grey[300],
                  color: AppStyleConfig.secondaryColor,
                ),
              ],
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
          SizedBox(
            width: 100.0,
            child: ElevatedButton(
              onPressed: _onStepCancel,
              style: AppStyleConfig.defaultButtonStyle,
              child: Text(
                _currentStep == 0 ? 'Cancel' : 'Back',
              ),
            ),
          ),
          SizedBox(
            width: 100.0,
            child: ElevatedButton(
              onPressed: _onStepContinue,
              style: AppStyleConfig.secondaryButtonStyle,
              child:
                  Text(_currentStep == _steps.length - 1 ? 'Submit' : 'Next'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccount() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            RequiredTextFormField(
              controller: _emailController,
              hintText: 'Email',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                const pattern = r'^[^@]+@[^@]+\.[^@]+';
                final regExp = RegExp(pattern);
                if (!regExp.hasMatch(value)) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0),
            RequiredTextFormField(
              controller: _usernameController,
              hintText: 'Username',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0),
            RequiredTextFormField(
              controller: _passwordController,
              hintText: 'Password',
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                const pattern =
                    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$';
                final regExp = RegExp(pattern);
                if (!regExp.hasMatch(value)) {
                  return 'Password must include uppercase letter, lowercase letter, and number';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileAndAddress() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Form(
            key: _profileFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(title: 'Profile Information'),
                RequiredTextFormField(
                  controller: _fullNameController,
                  hintText: 'Full Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                RequiredTextFormField(
                  controller: _birthdayController,
                  hintText: 'Birthday',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter birthday';
                    }
                    return null;
                  },
                  readOnly: true,
                  onTap: () {
                    _selectDate(context, _birthdayController);
                  },
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                const SizedBox(height: 20.0),
                RequiredTextFormField(
                  controller: _birthPlaceController,
                  hintText: 'Birth Place',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter birth place';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                RequiredTextFormField(
                  controller: _joinDateController,
                  hintText: 'Join Date',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter join date';
                    }
                    return null;
                  },
                  readOnly: true,
                  onTap: () {
                    _selectDate(context, _joinDateController);
                  },
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                const SizedBox(height: 20.0),
                IntlPhoneField(
                  controller: _phoneNumberController,
                  decoration: AppStyleConfig.inputDecoration.copyWith(
                    hintText: 'Phone Number',
                    labelText: 'Phone Number *',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                    counterText: '',
                  ),
                  initialCountryCode: 'ID',
                  onChanged: (phone) {},
                ),
                const SizedBox(height: 20.0),
                ToggleButton(
                  isSelected: _selectedGenderToggle,
                  labels: const ['Male', 'Female', 'Other'],
                  onPressed: (index) {
                    setState(() {
                      for (int i = 0; i < _selectedGenderToggle.length; i++) {
                        _selectedGenderToggle[i] = i == index;
                      }
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                RequiredDropdownButtonFormField(
                  value: _selectedBedRoom,
                  hintText: 'Bed Room',
                  onChanged: (value) {
                    setState(() {
                      _selectedBedRoom = value;
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                      value: 'bedroom-uuid-1',
                      child: Text('Bedroom 1'),
                    ),
                    DropdownMenuItem(
                      value: 'bedroom-uuid-2',
                      child: Text('Bedroom 2'),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                RequiredTextFormField(
                  controller: _guardianFullNameController,
                  hintText: 'Guardian Full Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter guardian full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                RequiredDropdownButtonFormField(
                  value: _selectedFamilyRelation,
                  hintText: 'Family Relation',
                  onChanged: (value) {
                    setState(() {
                      _selectedFamilyRelation = value;
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                      value: 'guardian-type-uuid-1',
                      child: Text('Ibu kandung'),
                    ),
                    DropdownMenuItem(
                      value: 'guardian-type-uuid-2',
                      child: Text('Ayah Kandung'),
                    ),
                    DropdownMenuItem(
                      value: 'guardian-type-uuid-3',
                      child: Text('Paman'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          const SectionTitle(title: 'Address Information'),
          Form(
            key: _addressFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OptionalTextFormField(
                  controller: _streetController,
                  hintText: 'Street',
                ),
                const SizedBox(height: 20.0),
                OptionalTextFormField(
                  controller: _urbanVillageController,
                  hintText: 'Urban Village',
                ),
                const SizedBox(height: 20.0),
                OptionalTextFormField(
                  controller: _subdistrictController,
                  hintText: 'Subdistrict',
                ),
                const SizedBox(height: 20.0),
                OptionalTextFormField(
                  controller: _cityController,
                  hintText: 'City',
                ),
                const SizedBox(height: 20.0),
                OptionalTextFormField(
                  controller: _provinceController,
                  hintText: 'Province',
                ),
                const SizedBox(height: 20.0),
                OptionalTextFormField(
                  controller: _postalCodeController,
                  hintText: 'Postal Code',
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocument() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: _documents.isEmpty
          ? _buildUploadSection()
          : MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              itemCount: _documents.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index < _documents.length) {
                  return DocumentItem(document: _documents[index]);
                } else {
                  return const UploadCard();
                }
              },
            ),
    );
  }

  Widget _buildUploadSection() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.cloud_upload, size: 100),
          const SizedBox(height: 20),
          const Text(
            'Upload orphan documents here',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: ElevatedButton(
              onPressed: _uploadDocument,
              style: AppStyleConfig.secondaryButtonStyle,
              child: const Text("Upload"),
            ),
          ),
        ],
      ),
    );
  }

  void _uploadDocument() {
    setState(() {
      _documents.add(Document(
        name: "example2.pdf",
        type: 'pdf',
        url: 'https://example.com/example2.pdf',
      ));
    });
  }
}
