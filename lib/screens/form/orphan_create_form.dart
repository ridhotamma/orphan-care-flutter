import 'package:flutter/material.dart';
import 'package:frontend_flutter/models/address_model.dart';
import 'package:frontend_flutter/models/bedroom_model.dart';
import 'package:frontend_flutter/models/guardian_model.dart';
import 'package:frontend_flutter/models/profile_model.dart';
import 'package:frontend_flutter/models/user_model.dart';
import 'package:frontend_flutter/services/bedroom_service.dart';
import 'package:frontend_flutter/services/location_service.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:frontend_flutter/services/user_service.dart';
import 'package:frontend_flutter/utils/response_handler_utils.dart';
import 'package:frontend_flutter/widgets/input/required_text_form_field.dart';
import 'package:frontend_flutter/widgets/input/optional_text_form_field.dart';
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

  List<Map<String, dynamic>> _provinces = [];
  List<Map<String, dynamic>> _cities = [];
  List<Map<String, dynamic>> _subDistricts = [];
  List<Map<String, dynamic>> _urbanVillages = [];

  List<GuardianType> _guardianTypes = [];
  List<BedRoom> _bedrooms = [];

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<bool> _selectedGenderToggle = [true, false, false];
  String _selectedGender = 'Male';

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
    final provinces = await LocationService().fetchProvinces();

    setState(() {
      _provinces = provinces;
      _cities = [];
      _subDistricts = [];
      _urbanVillages = [];
    });
  }

  void _fetchCities(String provinceId) async {
    final cities = await LocationService().fetchCities(provinceId);

    setState(() {
      _cities = cities;
      _subDistricts = [];
      _urbanVillages = [];
    });
  }

  void _fetchSubDistricts(String regencyId) async {
    final subDistricts = await LocationService().fetchSubDistricts(regencyId);

    setState(() {
      _subDistricts = subDistricts;
      _urbanVillages = [];
    });
  }

  void _fetchUrbanVillages(String districtId) async {
    final urbanVillages =
        await LocationService().fetchUrbanVillages(districtId);

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

        Profile profile = Profile(
          profilePicture: '',
          bio: '',
          leaveDate: '',
          fullName: _fullNameController.text,
          bedRoomId: _selectedBedRoom?.id,
          bedRoom: _selectedBedRoom,
          address: address,
          birthPlace: _birthPlaceController.text,
          joinDate: _joinDateController.text,
          birthday: _birthPlaceController.text,
          phoneNumber: _phoneNumberController.text,
          guardian: guardian,
          gender: _selectedGender,
        );

        UserRequest userRequest = UserRequest(
          profile: profile,
          email: _emailController.text,
          username: _usernameController.text,
          roles: ['ROLE_USER'],
          password: _passwordController.text,
          active: true,
        );

        try {
          UserService(context: context).createUser(userRequest.toJson());
        } catch (e) {
          ResponseHandlerUtils.onSubmitFailed(context, "Failed to Create User");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  items: _bedrooms,
                  itemAsString: (item) {
                    return item.name!;
                  },
                  dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration:
                          AppStyleConfig.inputDecoration.copyWith(
                    labelText: 'Bed Room',
                    hintText: 'Select Bed Room',
                  )),
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
                  items: _guardianTypes,
                  itemAsString: (item) {
                    return item.name;
                  },
                  dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration:
                          AppStyleConfig.inputDecoration.copyWith(
                    labelText: 'Family Relation',
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
          const SizedBox(height: 20.0),
          const SectionTitle(title: 'Address Information'),
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
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
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
        id: 'random-id',
        name: "example2.pdf",
        documentType: DocumentType(id: 'random-id', name: 'PDF', type: 'pdf'),
        url: 'https://example.com/example2.pdf',
      ));
    });
  }
}
