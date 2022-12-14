import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/packet.dart';
import '../shared/dialog_utils.dart';

import 'packet_manager.dart';

class EditPacketScreen extends StatefulWidget {
  static const routeName = '/edit-packet';

  EditPacketScreen(
    Packet? packet, {
    super.key,
  }) {
    if (packet == null) {
      this.packet = Packet(
        id: null,
        title: '',
        location: '',
        description: '',
        price: 0,
        image: ''
      );
    } else {
      this.packet = packet;
    }
  }

  late final Packet packet;

  @override
  State<EditPacketScreen> createState() => _EditPacketScreenState();
}

class _EditPacketScreenState extends State<EditPacketScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _editForm = GlobalKey<FormState>();

  late Packet _editPacket;

  var _isLoading = false;

  bool _isValidImageUrl(String value) {
    return (value.startsWith('assets')) &&
        (value.endsWith('.png') ||
            value.endsWith('.jpg') ||
            value.endsWith('.jpeg'));
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(() {
      if (!_imageUrlFocusNode.hasFocus) {
        if (!_isValidImageUrl(_imageUrlController.text)) {
          return;
        }
        setState(() {});
      }
    });
    _editPacket = widget.packet;
    _imageUrlController.text = _editPacket.image;
    super.initState();
  }

  @override
  void dipose() {
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _editForm.currentState!.validate();
    if (!isValid) {
      return;
    }
    _editForm.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      final packetsManager = context.read<PacketsManager>();
      if (_editPacket.id != null) {
        await packetsManager.updatePacket(_editPacket);
      } else {
        await packetsManager.addPacket(_editPacket);
      }
    } catch (error) {
      await showErrorDialog(context, 'Some went wrong.');
    }

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Packet'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveForm,
            )
          ],
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _editForm,
                  child: ListView(
                    children: <Widget>[
                      buildTitleField(),
                      buildLocationField(),
                      buildPriceField(),
                      buildDescriptionField(),
                      buildPacketPreview(),
                    ],
                  ),
                ),
              ));
  }

  TextFormField buildTitleField() {
    return TextFormField(
      initialValue: _editPacket.title,
      decoration: const InputDecoration(labelText: 'Title'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value';
        }
        return null;
      },
      onSaved: (value) {
        _editPacket = _editPacket.copyWith(title: value);
      },
    );
  }

  TextFormField buildLocationField() {
    return TextFormField(
      initialValue: _editPacket.location,
      decoration: const InputDecoration(labelText: 'Location'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value';
        }
        return null;
      },
      onSaved: (value) {
        _editPacket = _editPacket.copyWith(location: value);
      },
    );
  }


  

  TextFormField buildPriceField() {
    return TextFormField(
      initialValue: _editPacket.price.toString(),
      decoration: const InputDecoration(labelText: 'Price'),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a price.';
        }
        if (double.tryParse(value) == null) {
          return 'Please enter a valid number.';
        }
        if (double.parse(value) <= 0) {
          return 'Please enter a number greater than zero.';
        }
        return null;
      },
      onSaved: (value) {
        _editPacket = _editPacket.copyWith(price: double.parse(value!));
      },
    );
  }

  TextFormField buildDescriptionField() {
    return TextFormField(
      initialValue: _editPacket.description,
      decoration: const InputDecoration(labelText: 'Description'),
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a description.';
        }
        if (value.length < 10) {
          return 'Should be at least 10 characters long.';
        }
        return null;
      },
      onSaved: (value) {
        _editPacket = _editPacket.copyWith(description: value);
      },
    );
  }

  Widget buildPacketPreview() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(
            top: 8,
            right: 10,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _imageUrlController.text.isEmpty
              ? const Text('Enter a URL')
              : FittedBox(
                  child: Image(
                    image: AssetImage(_imageUrlController.text),
                    fit: BoxFit.cover,
                  )
                ),
        ),
        Expanded(child: buildImageURLField()),
      ],
    );
  }

  TextFormField buildImageURLField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Image URL'),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      controller: _imageUrlController,
      focusNode: _imageUrlFocusNode,
      onFieldSubmitted: (value) => _saveForm(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a valid image URL.';
        }
        if (!_isValidImageUrl(value)) {
          return 'Please enter a valid image URL.';
        }
        return null;
      },
      onSaved: (value) {
        _editPacket = _editPacket.copyWith(image: value);
      },
    );
  }
}