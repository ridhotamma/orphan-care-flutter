import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/widgets/document/document_item.dart';
import 'package:frontend_flutter/widgets/document/upload_card.dart';
import 'package:frontend_flutter/models/document_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';
import 'package:intl/intl.dart';

class OrphanCreateForm extends StatefulWidget {
  static const routeName = '/main/home/orphan_details/create';

  const OrphanCreateForm({super.key});

  @override
  State<OrphanCreateForm> createState() => _OrphanCreateFormState();
}

class _OrphanCreateFormState extends State<OrphanCreateForm> {
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

  String? _selectedGender;
  String? _selectedBedRoom;
  String? _selectedGuardian;

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
      appBar: const CustomAppBar(
        title: 'Create User Form',
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
      color: Colors.grey[200],
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
              style: AppStyleConfig.primaryTextButtonStyle,
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
            _buildRequiredTextFormField(
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
            _buildRequiredTextFormField(
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
            _buildRequiredTextFormField(
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
                  return 'Password must contain at least 1 uppercase letter, 1 lowercase letter, and 1 number';
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
                _buildSectionTitle('Profile Information'),
                _buildRequiredTextFormField(
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
                _buildRequiredTextFormField(
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
                _buildRequiredTextFormField(
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
                _buildRequiredTextFormField(
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
                _buildRequiredTextFormField(
                  controller: _phoneNumberController,
                  hintText: 'Phone Number',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                _buildRequiredDropdownButtonFormField(
                  value: _selectedGender,
                  hintText: 'Gender',
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                      value: 'MALE',
                      child: Text('Male'),
                    ),
                    DropdownMenuItem(
                      value: 'FEMALE',
                      child: Text('Female'),
                    ),
                    DropdownMenuItem(
                      value: 'OTHER',
                      child: Text('Other'),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                _buildRequiredDropdownButtonFormField(
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
                _buildRequiredDropdownButtonFormField(
                  value: _selectedGuardian,
                  hintText: 'Guardian',
                  onChanged: (value) {
                    setState(() {
                      _selectedGuardian = value;
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                      value: 'guardian-uuid-1',
                      child: Text('Guardian 1'),
                    ),
                    DropdownMenuItem(
                      value: 'guardian-uuid-2',
                      child: Text('Guardian 2'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          _buildSectionTitle('Address Information'),
          Form(
            key: _addressFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildOptionalTextFormField(
                  controller: _streetController,
                  hintText: 'Street',
                ),
                const SizedBox(height: 20.0),
                _buildOptionalTextFormField(
                  controller: _urbanVillageController,
                  hintText: 'Urban Village',
                ),
                const SizedBox(height: 20.0),
                _buildOptionalTextFormField(
                  controller: _subdistrictController,
                  hintText: 'Subdistrict',
                ),
                const SizedBox(height: 20.0),
                _buildOptionalTextFormField(
                  controller: _cityController,
                  hintText: 'City',
                ),
                const SizedBox(height: 20.0),
                _buildOptionalTextFormField(
                  controller: _provinceController,
                  hintText: 'Province',
                ),
                const SizedBox(height: 20.0),
                _buildOptionalTextFormField(
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
            'Upload your documents here',
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

  Widget _buildRequiredTextFormField({
    required TextEditingController controller,
    required String hintText,
    required FormFieldValidator<String>? validator,
    bool readOnly = false,
    VoidCallback? onTap,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: AppStyleConfig.inputDecoration.copyWith(
        hintText: hintText,
        labelText: '$hintText *',
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }

  Widget _buildOptionalTextFormField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      decoration: AppStyleConfig.inputDecoration.copyWith(
        hintText: hintText,
        labelText: hintText,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
      ),
      keyboardType: keyboardType,
    );
  }

  Widget _buildRequiredDropdownButtonFormField({
    required String? value,
    required String hintText,
    required ValueChanged<String?> onChanged,
    required List<DropdownMenuItem<String>> items,
    FormFieldValidator<String>? validator,
  }) {
    return DropdownButtonFormField<String>(
      decoration: AppStyleConfig.inputDecoration.copyWith(
        hintText: hintText,
        labelText: '$hintText *',
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
      ),
      value: value,
      onChanged: onChanged,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please select $hintText';
            }
            return null;
          },
      items: items,
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
