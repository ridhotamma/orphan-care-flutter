import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';

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
  final _leaveDateController = TextEditingController();
  final _bioController = TextEditingController();
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

  int _currentStep = 0;

  final List<String> _steps = [
    'Basic Information',
    'Profile and Address',
    'Document',
    'Payment & Review',
  ];

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _birthdayController.dispose();
    _birthPlaceController.dispose();
    _joinDateController.dispose();
    _leaveDateController.dispose();
    _bioController.dispose();
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
                  case 'Payment & Review':
                    return _buildPaymentReview();
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
                  value: (_currentStep + 1) / _steps.length,
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
            TextFormField(
              controller: _emailController,
              decoration: AppStyleConfig.inputDecoration.copyWith(
                hintText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
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
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: _usernameController,
              decoration: AppStyleConfig.inputDecoration.copyWith(
                hintText: 'Username',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: AppStyleConfig.inputDecoration.copyWith(
                hintText: 'Password',
              ),
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
                const SectionTitle(title: 'Profile Information'),
                TextFormField(
                  controller: _fullNameController,
                  decoration: AppStyleConfig.inputDecoration.copyWith(
                    hintText: 'Full Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _birthdayController,
                  decoration: AppStyleConfig.inputDecoration.copyWith(
                    hintText: 'Birthday',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter birthday';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _birthPlaceController,
                  decoration: AppStyleConfig.inputDecoration.copyWith(
                    hintText: 'Birth Place',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter birth place';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _joinDateController,
                  decoration: AppStyleConfig.inputDecoration.copyWith(
                    hintText: 'Join Date',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter join date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _leaveDateController,
                  decoration: AppStyleConfig.inputDecoration.copyWith(
                    hintText: 'Leave Date',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter leave date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _bioController,
                  decoration: AppStyleConfig.inputDecoration.copyWith(
                    hintText: 'Bio',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter bio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: AppStyleConfig.inputDecoration.copyWith(
                    hintText: 'Phone Number',
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                DropdownButtonFormField<String>(
                  decoration: AppStyleConfig.inputDecoration.copyWith(
                    hintText: 'Gender',
                  ),
                  value: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select gender';
                    }
                    return null;
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
                DropdownButtonFormField<String>(
                  decoration: AppStyleConfig.inputDecoration.copyWith(
                    hintText: 'Bed Room',
                  ),
                  value: _selectedBedRoom,
                  onChanged: (value) {
                    setState(() {
                      _selectedBedRoom = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select bed room';
                    }
                    return null;
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
                DropdownButtonFormField<String>(
                  decoration: AppStyleConfig.inputDecoration.copyWith(
                    hintText: 'Guardian',
                  ),
                  value: _selectedGuardian,
                  onChanged: (value) {
                    setState(() {
                      _selectedGuardian = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select guardian';
                    }
                    return null;
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
          const SectionTitle(title: 'Address Information'),
          Form(
            key: _addressFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _streetController,
                  decoration: AppStyleConfig.inputDecoration.copyWith(
                    hintText: 'Street',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter street';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _urbanVillageController,
                  decoration: AppStyleConfig.inputDecoration.copyWith(
                    hintText: 'Urban Village',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter urban village';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _subdistrictController,
                  decoration: AppStyleConfig.inputDecoration.copyWith(
                    hintText: 'Subdistrict',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter subdistrict';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _cityController,
                  decoration: AppStyleConfig.inputDecoration.copyWith(
                    hintText: 'City',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter city';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _provinceController,
                  decoration: AppStyleConfig.inputDecoration.copyWith(
                    hintText: 'Province',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter province';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _postalCodeController,
                  decoration: AppStyleConfig.inputDecoration.copyWith(
                    hintText: 'Postal Code',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter postal code';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocument() {
    return const Center(
      child: Text('Document Form Placeholder'),
    );
  }

  Widget _buildPaymentReview() {
    return const Center(
      child: Text('Payment & Review Form Placeholder'),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
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
