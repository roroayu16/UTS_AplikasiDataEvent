// ignore_for_file: prefer_const_constructors, duplicate_ignore, non_constant_identifier_names

import 'package:event_surabaya/models/acara_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

enum FormMode { create, update }

class CreateEdit extends StatefulWidget {
  const CreateEdit({super.key, required this.mode, this.acaraModel});

  final FormMode mode;
  final AcaraModel? acaraModel;

  @override
  State<CreateEdit> createState() => _CreateEditState();
}

class _CreateEditState extends State<CreateEdit> {
  final TextEditingController _NamaEventController = TextEditingController();
  final TextEditingController _GuestController = TextEditingController();
  final TextEditingController _TanggalController = TextEditingController();
  final TextEditingController _LokasiController = TextEditingController();
  final TextEditingController _HtmController = TextEditingController();

  @override
  initState() {
    super.initState();
    if (widget.mode == FormMode.update) {
      _NamaEventController.text = widget.acaraModel!.namaEvent;
      _GuestController.text = widget.acaraModel!.guest;
      _TanggalController.text = widget.acaraModel!.tanggal;
      _LokasiController.text = widget.acaraModel!.lokasi;
      _HtmController.text = widget.acaraModel!.htm;
    }
  }

  getData() {
    return AcaraModel(
      namaEvent: _NamaEventController.text,
      guest: _GuestController.text,
      tanggal: _TanggalController.text,
      lokasi: _LokasiController.text,
      htm: _HtmController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Add Event'),
        trailing: GestureDetector(
          onTap: () {
            Navigator.pop(context, getData());
          },
          child: Text(widget.mode == FormMode.create ? 'Add' : 'Edit'),
        ),
      ),
      child: SafeArea(
        child: CupertinoFormSection(
          header:
              Text(widget.mode == FormMode.create ? 'Add Data' : 'Edit Data'),
          children: [
            CupertinoFormRow(
              prefix: Text(
                'Nama Event : ',
                style: TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
              child: CupertinoTextFormFieldRow(
                controller: _NamaEventController,
                placeholder: 'Name of Event',
              ),
            ),
            CupertinoFormRow(
              prefix: Text(
                'Bintang Tamu : ',
                style: TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
              child: CupertinoTextFormFieldRow(
                controller: _GuestController,
                placeholder: 'Guest Star',
              ),
            ),
            CupertinoFormRow(
              prefix: Text(
                'Tanggal : ',
                style: TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
              child: CupertinoTextFormFieldRow(
                controller: _TanggalController,
                placeholder: 'Date of Event',
              ),
            ),
            CupertinoFormRow(
              prefix: Text(
                'Lokasi : ',
                style: TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
              child: CupertinoTextFormFieldRow(
                controller: _LokasiController,
                placeholder: 'Location of Event',
              ),
            ),
            CupertinoFormRow(
              prefix: Text(
                'Biaya Masuk : ',
                style: TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
              child: CupertinoTextFormFieldRow(
                controller: _HtmController,
                placeholder: 'HTM',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
