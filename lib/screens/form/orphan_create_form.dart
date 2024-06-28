import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';

class OrphanCreateForm extends StatefulWidget {
  static const routeName = '/main/home/orphan_details/create';

  const OrphanCreateForm({super.key});

  @override
  State<OrphanCreateForm> createState() => _OrphanCreateFormState();
}

class _OrphanCreateFormState extends State<OrphanCreateForm> {
  int _currentStep = 0;

  final List<String> _steps = [
    'Basic Information',
    'Profile and Address',
    'Document',
    'Payment & Review',
  ];

  void _onStepContinue() {
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

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create User Form',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppStyleConfig.secondaryColor,
        foregroundColor: Colors.white,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Step ${_currentStep + 1} of ${_steps.length}',
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
    );
  }

  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextButton(
            onPressed: _onStepCancel,
            style: AppStyleConfig.secondaryTextButtonStyle,
            child: const Text('Back'),
          ),
          ElevatedButton(
            onPressed: _onStepContinue,
            style: AppStyleConfig.secondaryButtonStyle,
            child: Text(_currentStep == _steps.length - 1 ? 'Submit' : 'Next'),
          ),
        ],
      ),
    );
  }

  Widget _buildAccount() {
    return const Center(
      child: Text('Basic Information Form Placeholder'),
    );
  }

  Widget _buildProfileAndAddress() {
    return const Center(
      child: Text('Profile and Address Form Placeholder'),
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
