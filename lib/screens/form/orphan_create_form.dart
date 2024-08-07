import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/address_model.dart';
import 'package:frontend_flutter/models/bedroom_model.dart';
import 'package:frontend_flutter/models/guardian_model.dart';
import 'package:frontend_flutter/models/user_model.dart';
import 'package:frontend_flutter/services/bedroom_service.dart';
import 'package:frontend_flutter/services/location_service.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:frontend_flutter/services/upload_service.dart';
import 'package:frontend_flutter/services/user_service.dart';
import 'package:frontend_flutter/utils/response_handler_util.dart';
import 'package:frontend_flutter/widgets/input/required_text_form_field.dart';
import 'package:frontend_flutter/widgets/input/optional_text_form_field.dart';
import 'package:frontend_flutter/widgets/input/toggle_button.dart';
import 'package:frontend_flutter/config/app_style_config.dart';
import 'package:frontend_flutter/widgets/shared/custom_app_bar.dart';

import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class OrphanCreateForm extends StatefulWidget {
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

  final _guardianFullNameController = TextEditingController();

  Map<String, dynamic>? _selectedProvince;
  Map<String, dynamic>? _selectedDistrict;
  Map<String, dynamic>? _selectedRegency;
  Map<String, dynamic>? _selectedVillage;

  GuardianType? _selectedGuardianType;
  BedRoom? _selectedBedRoom;
  String? _profilePictureUrl;

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
    'Profile Details',
    'Address',
  ];

  List<Map<String, dynamic>> _provinces = [];
  List<Map<String, dynamic>> _cities = [];
  List<Map<String, dynamic>> _subDistricts = [];
  List<Map<String, dynamic>> _urbanVillages = [];

  List<GuardianType> _guardianTypes = [];
  List<BedRoom> _bedrooms = [];

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<bool> _selectedGenderToggle = [true, false, false];

  String _selectedGender = 'MALE';
  bool _isSubmitting = false;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _fetchProvinces();
    _fetchGuardianTypes();
    _fetchBedrooms();
  }

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

  void _fetchBedrooms() async {
    final bedrooms = await BedroomService(context: context).fetchBedRooms();

    setState(() {
      _bedrooms = bedrooms;
    });
  }

  void _fetchGuardianTypes() async {
    final guardianTypes =
        await UserService(context: context).fetchGuardianTypes();

    setState(() {
      _guardianTypes = guardianTypes;
    });
  }

  void _fetchProvinces() async {
    final provinces = await LocationService(context: context).fetchProvinces();

    setState(() {
      _provinces = provinces;
      _cities = [];
      _subDistricts = [];
      _urbanVillages = [];
    });
  }

  void _fetchCities(String provinceId) async {
    final cities =
        await LocationService(context: context).fetchCities(provinceId);

    setState(() {
      _cities = cities;
      _subDistricts = [];
      _urbanVillages = [];
    });
  }

  void _fetchSubDistricts(String regencyId) async {
    final subDistricts =
        await LocationService(context: context).fetchSubDistricts(regencyId);

    setState(() {
      _subDistricts = subDistricts;
      _urbanVillages = [];
    });
  }

  void _fetchUrbanVillages(String districtId) async {
    final urbanVillages =
        await LocationService(context: context).fetchUrbanVillages(districtId);

    setState(() {
      _urbanVillages = urbanVillages;
    });
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
        Address address = Address(
          city: _selectedRegency?['name'],
          province: _selectedProvince?['name'],
          street: _streetController.text,
          subdistrict: _selectedDistrict?['name'],
          urbanVillage: _selectedVillage?['name'],
          postalCode: _postalCodeController.text,
        );

        Guardian guardian = Guardian(
          id: '',
          phoneNumber: '',
          address: address,
          fullName: _guardianFullNameController.text,
          guardianType: _selectedGuardianType,
          guardianTypeId: _selectedGuardianType?.id,
        );

        UserRequest userRequest = UserRequest(
          email: _emailController.text,
          username: _usernameController.text,
          roles: ['ROLE_USER'],
          password: _passwordController.text,
          profilePicture: _profilePictureUrl ?? '',
          bio: '',
          fullName: _fullNameController.text,
          bedRoomId: _selectedBedRoom?.id ?? '',
          address: address.toJson(),
          birthPlace: _birthPlaceController.text,
          joinDate: _joinDateController.text,
          birthday: _birthdayController.text,
          phoneNumber: _phoneNumberController.text,
          guardian: guardian.toJson(),
          gender: _selectedGender,
          active: true,
        );

        setState(() {
          _isSubmitting = true;
        });

        try {
          UserService(context: context).createUser(userRequest.toJson());
        } catch (e) {
          ResponseHandlerUtils.onSubmitFailed(context, "Failed to Create User");
        } finally {
          setState(() {
            _isSubmitting = false;
          });
        }
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
    BuildContext context,
    TextEditingController controller,
  ) async {
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

  void _pickFile() async {
    setState(() {
      _isUploading = true;
    });

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'gif', 'webp', 'svg'],
        dialogTitle: 'Pick file from directory',
      );

      if (result != null) {
        final fileName = result.files.single.name;
        final fileBytes = result.files.single.bytes;

        if (mounted) {
          if (kIsWeb && fileBytes != null) {
            // Use file bytes for web
            UploadService(context: context)
                .uploadFileBytes(fileBytes, fileName)
                .then((data) {
              setState(() {
                _profilePictureUrl = data['url'];
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
                _profilePictureUrl = data['url'];
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
        backgroundColor: AppStyleConfig.primaryBackgroundColor,
        appBar: const CustomAppBar(
          title: 'Tambah Data Anak Asuh',
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
                      return _buildBasicInformationForm();
                    case 'Profile Details':
                      return _buildProfileForm();
                    case 'Address':
                      return _buildAddressForm();
                    default:
                      return const SizedBox.shrink();
                  }
                }).toList(),
              ),
            ),
            _buildControls(),
          ],
        ),
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
              onPressed: _isSubmitting ? null : _onStepContinue,
              style: AppStyleConfig.secondaryButtonStyle,
              child: _buildLoaderButton(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoaderButton() {
    if (_isSubmitting) {
      return const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2.0,
        ),
      );
    } else {
      return Text(_currentStep == _steps.length - 1 ? 'Submit' : 'Next');
    }
  }

  Widget _buildBasicInformationForm() {
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

  Widget _buildProfileForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _buildUploadProfilePicture(),
          Form(
            key: _profileFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  labels: _genders,
                  onPressed: (index) {
                    setState(() {
                      for (int i = 0; i < _selectedGenderToggle.length; i++) {
                        _selectedGenderToggle[i] = i == index;
                        _selectedGender = _genders[i].toUpperCase();
                      }
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                DropdownSearch<BedRoom>(
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter bedroom';
                    }
                    return null;
                  },
                  items: _bedrooms,
                  itemAsString: (item) {
                    return item.name!;
                  },
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration:
                        AppStyleConfig.inputDecoration.copyWith(
                      labelText: 'Bed Room *',
                      hintText: 'Select Bed Room',
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _selectedBedRoom = value;
                    });
                  },
                  selectedItem: _selectedBedRoom,
                  enabled: true,
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
                DropdownSearch<GuardianType>(
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter family relation';
                    }
                    return null;
                  },
                  items: _guardianTypes,
                  itemAsString: (item) {
                    return item.name;
                  },
                  dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration:
                          AppStyleConfig.inputDecoration.copyWith(
                    labelText: 'Family Relation *',
                    hintText: 'Select family relation',
                  )),
                  onChanged: (value) {
                    setState(() {
                      _selectedGuardianType = value;
                    });
                  },
                  selectedItem: _selectedGuardianType,
                  enabled: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadProfilePicture() {
    return Column(
      children: [
        _profilePictureUrl != null
            ? CircleAvatar(
                radius: 80.0,
                backgroundColor: AppStyleConfig.accentColor,
                backgroundImage: NetworkImage(_profilePictureUrl ?? ''),
              )
            : Container(
                width: 160,
                height: 160,
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppStyleConfig.accentColor,
                ),
                child: const Icon(
                  size: 80,
                  Icons.person_outline,
                  color: Colors.white,
                ),
              ),
        const SizedBox(
          height: 20,
        ),
        OutlinedButton.icon(
          onPressed: _pickFile,
          label: _isUploading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: AppStyleConfig.primaryColor,
                    strokeWidth: 2.0,
                  ),
                )
              : const Text(
                  'Upload photo',
                  style: TextStyle(color: Colors.black),
                ),
          icon: const Icon(Icons.upload_outlined),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _buildAddressForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Form(
            key: _addressFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownSearch<Map<String, dynamic>>(
                  items: _provinces,
                  itemAsString: (item) {
                    return item['name'];
                  },
                  dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration:
                          AppStyleConfig.inputDecoration.copyWith(
                    labelText: 'Province',
                    hintText: 'Select a province',
                  )),
                  onChanged: (value) {
                    setState(() {
                      _selectedProvince = value;
                      _fetchCities(value?['id']);
                    });
                  },
                  selectedItem: _selectedProvince,
                  enabled: true,
                ),
                const SizedBox(height: 20.0),
                DropdownSearch<Map<String, dynamic>>(
                  items: _cities,
                  itemAsString: (item) {
                    return item['name'];
                  },
                  dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration:
                          AppStyleConfig.inputDecoration.copyWith(
                    labelText: 'City',
                    hintText: 'Select a city',
                  )),
                  onChanged: (value) {
                    setState(() {
                      _selectedRegency = value;
                      _fetchSubDistricts(value?['id']);
                    });
                  },
                  selectedItem: _selectedRegency,
                ),
                const SizedBox(height: 20.0),
                DropdownSearch<Map<String, dynamic>>(
                  items: _subDistricts,
                  itemAsString: (item) {
                    return item['name'];
                  },
                  dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration:
                          AppStyleConfig.inputDecoration.copyWith(
                    labelText: 'Subdistrict',
                    hintText: 'Select a subdistrict',
                  )),
                  onChanged: (value) {
                    setState(() {
                      _selectedDistrict = value;
                      _fetchUrbanVillages(value?['id']);
                    });
                  },
                  selectedItem: _selectedDistrict,
                ),
                const SizedBox(height: 20.0),
                DropdownSearch<Map<String, dynamic>>(
                  items: _urbanVillages,
                  itemAsString: (item) {
                    return item['name'];
                  },
                  dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration:
                          AppStyleConfig.inputDecoration.copyWith(
                    labelText: 'Urban Village',
                    hintText: 'Select an urban village',
                  )),
                  onChanged: (value) {
                    setState(() {
                      _selectedVillage = value;
                    });
                  },
                  selectedItem: _selectedVillage,
                ),
                const SizedBox(height: 20.0),
                OptionalTextFormField(
                  controller: _streetController,
                  hintText: 'Street',
                  maxLines: null,
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
}
