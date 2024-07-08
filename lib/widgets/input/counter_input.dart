import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';

class CounterInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const CounterInput({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  State<CounterInput> createState() => _CounterInputState();
}

class _CounterInputState extends State<CounterInput> {
  void _incrementQuantity() {
    int currentQuantity = int.tryParse(widget.controller.text) ?? 0;
    widget.controller.text = (currentQuantity + 1).toString();
  }

  void _decrementQuantity() {
    int currentQuantity = int.tryParse(widget.controller.text) ?? 0;
    if (currentQuantity > 1) {
      widget.controller.text = (currentQuantity - 1).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: widget.controller,
            decoration: AppStyleConfig.inputDecoration.copyWith(
              hintText: widget.hintText,
              labelText: widget.hintText,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
            ),
          ),
        ),
        SizedBox(
          width: 65,
          height: 45,
          child: IconButton(
            color: Colors.white,
            style: IconButton.styleFrom(
              backgroundColor: AppStyleConfig.errorColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            icon: const Icon(Icons.remove),
            onPressed: _decrementQuantity,
          ),
        ),
        SizedBox(
          width: 65,
          height: 45,
          child: IconButton(
            color: Colors.white,
            style: IconButton.styleFrom(
              backgroundColor: AppStyleConfig.successColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            icon: const Icon(Icons.add),
            onPressed: _incrementQuantity,
          ),
        ),
      ],
    );
  }
}
