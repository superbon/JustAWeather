

// features/location/presentation/view/edit_location_dialog.dart
import 'package:flutter/material.dart';
import '../../domain/entities/saved_location.dart';
import 'package:uuid/uuid.dart';

class EditLocationDialog extends StatefulWidget {
  final SavedLocation? location;
  const EditLocationDialog({super.key, this.location});

  @override
  State<EditLocationDialog> createState() => _EditLocationDialogState();
}

class _EditLocationDialogState extends State<EditLocationDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _countryController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.location?.name ?? '');
    _countryController = TextEditingController(text: widget.location?.country ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.location == null ? 'Add Location' : 'Edit Location'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Location Name'),
              textCapitalization: TextCapitalization.words, 
              validator: (value) => value == null || value.isEmpty ? 'Enter a name' : null,
            ),
            TextFormField(
              controller: _countryController,
              decoration: const InputDecoration(labelText: 'Country (optional)'),
              textCapitalization: TextCapitalization.words, 
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              Navigator.pop(
                context,
                SavedLocation(
                  id: widget.location?.id ?? const Uuid().v4(),
                  name: _nameController.text,
                  country: _countryController.text.isEmpty ? null : _countryController.text,
                ),
              );
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
