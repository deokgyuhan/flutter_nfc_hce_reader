import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:app_settings/app_settings.dart';
import 'package:nfc_manager/nfc_manager.dart';

void main() {
  runApp(NfcReaderView());
}

class NfcReaderView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NfcReaderViewState();
}

class NfcReaderViewState extends State<NfcReaderView> {
  ValueNotifier<dynamic> result = ValueNotifier(null);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _permissionCheck();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Nfc Hce Reader Example')),
        body: SafeArea(
          child: FutureBuilder<bool>(
            future: NfcManager.instance.isAvailable(),
            builder: (context, ss) =>
            ss.data != true
                ? Center(child: Text('NfcManager.isAvailable(): ${ss.data}'))
                : Flex(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.vertical,
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.all(4),
                    constraints: BoxConstraints.expand(),
                    decoration: BoxDecoration(border: Border.all()),
                    child: SingleChildScrollView(
                      child: ValueListenableBuilder<dynamic>(
                        valueListenable: result,
                        builder: (context, value, _) =>
                            Text('${value ?? ''}'),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: GridView.count(
                    padding: EdgeInsets.all(4),
                    crossAxisCount: 2,
                    childAspectRatio: 4,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    children: [
                      ElevatedButton(
                          child: Text('Tag Read'), onPressed: () async {
                        _tagRead();
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _tagRead() {
    print('-------------->tag read start......');

    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      print('-------------->tag discovered');
      print('-------------->tag.data: ' + tag.data.toString());

      // result.value = tag.data['ndef']['cachedMessage']['records'][0]['payload'];

      var record = tag.data['ndef']['cachedMessage']['records'][0];
      // print(record);

      var identifier = Uint8List.fromList(record['identifier']);
      // print(identifier);

      var payload = Uint8List.fromList(record['payload']);
      // print(payload);

      var type = Uint8List.fromList(record['type']);
      // print(type);

      var typeNameFormat = Uint8List.fromList([record['typeNameFormat']]);
      // print(typeNameFormat);

      var error = [
        2, 101, 110, 67, 105, 97, 111, 44, 32, 99, 111, 109, 101, 32, 118, 97, 63
      ]; // \^BenCiao, come v<…>

      if (payload.toString() != error.toString()) {
        //payload list index from 1 to list's length
        result.value = utf8.decode(Uint8List.fromList(payload.sublist(1)));
      } else {
        print('Please retry scanning');
      }

      // decoing
      // String payloadStr = Utf8Codec().decode(payload);
      // String typeStr = Utf8Codec().decode(type);
      // String typeNameFormatStr = Utf8Codec().decode(typeNameFormat);

      // decoding value print
      // print('Payload: $payloadStr');
      // print('Type: $typeStr');
      // print('TypeNameFormat: $typeNameFormatStr');

      NfcManager.instance.stopSession();
    });
  }

  void _permissionCheck() async {
    if (!(await NfcManager.instance.isAvailable())) {
      if (Platform.isAndroid) {
        AppSettings.openAppSettingsPanel(AppSettingsPanelType.nfc);
      }
    }
  }
}
