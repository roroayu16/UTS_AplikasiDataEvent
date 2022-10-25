import 'package:flutter/cupertino.dart';

import 'package:event_surabaya/Pages/acara_add.dart';
import 'package:flutter/material.dart';
import 'package:event_surabaya/models/acara_model.dart';

class AcaraTampilan extends StatefulWidget {
  const AcaraTampilan({super.key});

  @override
  State<AcaraTampilan> createState() => _AcaraTampilanState();
}

class _AcaraTampilanState extends State<AcaraTampilan> {
  final List<AcaraModel> _listAcaraModel = [
    AcaraModel(
        namaEvent: "Hallowen Party",
        guest: "Smash",
        tanggal: "29 Oktober 2022",
        lokasi: "Jl Kavling DPR no.23, cafe",
        htm: "Rp 90.000"),
    AcaraModel(
        namaEvent: "UMKM Party",
        guest: "Klantink",
        tanggal: "11 November 2022",
        lokasi: "Tunjungan Plaza",
        htm: "Free"),
  ];

  _showPopupMenu(BuildContext context, int index) {
    // ignore: non_constant_identifier_names
    final AcaraModelClicked = _listAcaraModel[index];

    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('${AcaraModelClicked.namaEvent}'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              final result = await Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => CreateEdit(
                    mode: FormMode.update,
                    acaraModel: AcaraModelClicked,
                  ),
                ),
              );
              if (result is AcaraModel) {
                setState(() {
                  _listAcaraModel[index] = result;
                });
              }
            },
            child: const Text(
              'Edit',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              showCupertinoModalPopup<void>(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                        title: const Text('Yakin ingin menghapus data ini?'),
                        content: Text(
                            'Data Event ${AcaraModelClicked.namaEvent} akan dihapus'),
                        actions: <CupertinoDialogAction>[
                          CupertinoDialogAction(
                              isDefaultAction: true,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('No')),
                          CupertinoDialogAction(
                              isDestructiveAction: true,
                              onPressed: () {
                                Navigator.pop(context);
                                setState(() {
                                  _listAcaraModel.removeAt(index);
                                });
                              },
                              child: const Text('Yes'))
                        ],
                      ));
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Event Surabaya'),
        trailing: GestureDetector(
          onTap: () async {
            final result = await Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) =>
                      const CreateEdit(mode: FormMode.create)),
            );
            if (result is AcaraModel) {
              setState(() {
                _listAcaraModel.add(result);
              });
            }
          },
          child: const Icon(
            CupertinoIcons.add_circled,
            size: 25,
          ),
        ),
      ),
      child: SafeArea(
        child: ListView.separated(
          itemCount: _listAcaraModel.length,
          itemBuilder: (context, index) {
            final item = _listAcaraModel[index];
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: GestureDetector(
                onTap: () => _showPopupMenu(context, index),
                child: Column(
                  children: [
                    Text(
                      item.namaEvent,
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        fontSize: 32,
                        //color: Colors.deepOrangeAccent,
                      ),
                    ),
                    Text(
                      'Guest Star : ${item.guest}',
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                    Text(
                      'Tanggal : ${item.tanggal}',
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                    Text(
                      'Lokasi :  ${item.lokasi}',
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                    Text(
                      'HTM :  ${item.htm}',
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: ((context, index) {
            return const Divider();
          }),
        ),
      ),
    );
  }
}
