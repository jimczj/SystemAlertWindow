import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:system_alert_window/system_alert_window.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

void callBack(String tag) {
  print(tag);
  switch (tag) {
    case "simple_button":
    case "updated_simple_button":
      SystemAlertWindow.closeSystemWindow(
          prefMode: SystemWindowPrefMode.OVERLAY);
      break;
    case "focus_button":
      print("Focus button has been called");
      break;
    default:
      print("OnClick event of $tag");
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  bool _isShowingWindow = false;
  bool _isUpdatedWindow = false;
  SystemWindowPrefMode prefMode = SystemWindowPrefMode.OVERLAY;

  @override
  void initState() {
    super.initState();
    _initPlatformState();
    _requestPermissions();
    SystemAlertWindow.registerOnClickListener((call) {
      SystemAlertWindow.closeSystemWindow(
          prefMode: SystemWindowPrefMode.OVERLAY);
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _initPlatformState() async {
    await SystemAlertWindow.enableLogs(true);
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await SystemAlertWindow.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> _requestPermissions() async {
    await SystemAlertWindow.requestPermissions(prefMode: prefMode);
  }

  void _showOverlayWindow() {
    if (!_isShowingWindow) {
      SystemWindowHeader header = SystemWindowHeader(
          title: SystemWindowText(
              text: "Incoming Call", fontSize: 10, textColor: Colors.black45),
          padding: SystemWindowPadding.setSymmetricPadding(12, 12),
          subTitle: SystemWindowText(
              text: "9898989899",
              fontSize: 14,
              fontWeight: FontWeight.BOLD,
              textColor: Colors.black87),
          decoration: SystemWindowDecoration(startColor: Colors.grey[100]),
          button: SystemWindowButton(
              text: SystemWindowText(
                  text: "Spam", fontSize: 10, textColor: Colors.black45),
              tag: "spam_btn"),
          buttonPosition: ButtonPosition.TRAILING);
      SystemWindowBody body = SystemWindowBody(
        rows: [
          EachRow(
            columns: [
              EachColumn(
                text: SystemWindowText(
                    text: "Some body", fontSize: 12, textColor: Colors.black45),
              ),
            ],
            gravity: ContentGravity.CENTER,
          ),
          EachRow(columns: [
            EachColumn(
                text: SystemWindowText(
                    text: "Long data of the body",
                    fontSize: 12,
                    textColor: Colors.black87,
                    fontWeight: FontWeight.BOLD),
                padding: SystemWindowPadding.setSymmetricPadding(6, 8),
                decoration: SystemWindowDecoration(
                    startColor: Colors.black12, borderRadius: 25.0),
                margin: SystemWindowMargin(top: 4)),
          ], gravity: ContentGravity.CENTER),
          EachRow(
            columns: [
              EachColumn(
                text: SystemWindowText(
                    text: "Description",
                    fontSize: 10,
                    textColor: Colors.black45),
              ),
            ],
            gravity: ContentGravity.LEFT,
            margin: SystemWindowMargin(top: 8),
          ),
          EachRow(
            columns: [
              EachColumn(
                text: SystemWindowText(
                    text: "Some random description.",
                    fontSize: 13,
                    textColor: Colors.black54,
                    fontWeight: FontWeight.BOLD),
              ),
            ],
            gravity: ContentGravity.LEFT,
          ),
        ],
        padding: SystemWindowPadding(left: 16, right: 16, bottom: 12, top: 12),
      );
      SystemWindowFooter footer = SystemWindowFooter(
          buttons: [
            SystemWindowButton(
              text: SystemWindowText(
                  text: "Simple button", fontSize: 12, textColor: Colors.blue),
              tag: "simple_button",
              padding:
                  SystemWindowPadding(left: 10, right: 10, bottom: 10, top: 10),
              width: 0,
              height: SystemWindowButton.WRAP_CONTENT,
              decoration: SystemWindowDecoration(
                  startColor: Colors.white,
                  endColor: Colors.white,
                  borderWidth: 0,
                  borderRadius: 0.0),
            ),
            SystemWindowButton(
              text: SystemWindowText(
                  text: "Focus button", fontSize: 12, textColor: Colors.white),
              tag: "focus_button",
              width: 0,
              padding:
                  SystemWindowPadding(left: 10, right: 10, bottom: 10, top: 10),
              height: SystemWindowButton.WRAP_CONTENT,
              decoration: SystemWindowDecoration(
                  startColor: Colors.lightBlueAccent,
                  endColor: Colors.blue,
                  borderWidth: 0,
                  borderRadius: 30.0),
            )
          ],
          padding:
              SystemWindowPadding(left: 16, right: 16, bottom: 12, top: 10),
          decoration: SystemWindowDecoration(startColor: Colors.white),
          buttonsPosition: ButtonPosition.CENTER);
      SystemAlertWindow.showSystemWindow(
          height: 230,
          header: header,
          body: body,
          footer: footer,
          margin: SystemWindowMargin(left: 8, right: 8, top: 200, bottom: 0),
          gravity: SystemWindowGravity.TOP,
          notificationTitle: "Incoming Call",
          notificationBody: "+1 646 980 4741",
          prefMode: prefMode,
          backgroundColor: Colors.black12,
          isDisableClicks: false);
      setState(() {
        _isShowingWindow = true;
      });
    } else if (!_isUpdatedWindow) {
      SystemWindowHeader header = SystemWindowHeader(
          title: SystemWindowText(
              text: "Outgoing Call", fontSize: 10, textColor: Colors.black45),
          padding: SystemWindowPadding.setSymmetricPadding(12, 12),
          subTitle: SystemWindowText(
              text: "8989898989",
              fontSize: 14,
              fontWeight: FontWeight.BOLD,
              textColor: Colors.black87),
          decoration: SystemWindowDecoration(startColor: Colors.grey[100]),
          button: SystemWindowButton(
              text: SystemWindowText(
                  text: "Spam", fontSize: 10, textColor: Colors.black45),
              tag: "spam_btn"),
          buttonPosition: ButtonPosition.TRAILING);
      SystemWindowBody body = SystemWindowBody(
        rows: [
          EachRow(
            columns: [
              EachColumn(
                text: SystemWindowText(
                    text: "Updated body",
                    fontSize: 12,
                    textColor: Colors.black45),
              ),
            ],
            gravity: ContentGravity.CENTER,
          ),
          EachRow(columns: [
            EachColumn(
                text: SystemWindowText(
                    text: "Updated long data of the body",
                    fontSize: 12,
                    textColor: Colors.black87,
                    fontWeight: FontWeight.BOLD),
                padding: SystemWindowPadding.setSymmetricPadding(6, 8),
                decoration: SystemWindowDecoration(
                    startColor: Colors.black12, borderRadius: 25.0),
                margin: SystemWindowMargin(top: 4)),
          ], gravity: ContentGravity.CENTER),
          EachRow(
            columns: [
              EachColumn(
                text: SystemWindowText(
                    text: "Description",
                    fontSize: 10,
                    textColor: Colors.black45),
              ),
            ],
            gravity: ContentGravity.LEFT,
            margin: SystemWindowMargin(top: 8),
          ),
          EachRow(
            columns: [
              EachColumn(
                text: SystemWindowText(
                    text: "Updated random description.",
                    fontSize: 13,
                    textColor: Colors.black54,
                    fontWeight: FontWeight.BOLD),
              ),
            ],
            gravity: ContentGravity.LEFT,
          ),
        ],
        padding: SystemWindowPadding(left: 16, right: 16, bottom: 12, top: 12),
      );
      SystemWindowFooter footer = SystemWindowFooter(
          buttons: [
            SystemWindowButton(
              text: SystemWindowText(
                  text: "Updated Simple button",
                  fontSize: 12,
                  textColor: Colors.blue),
              tag: "updated_simple_button",
              padding:
                  SystemWindowPadding(left: 10, right: 10, bottom: 10, top: 10),
              width: 0,
              height: SystemWindowButton.WRAP_CONTENT,
              decoration: SystemWindowDecoration(
                  startColor: Colors.white,
                  endColor: Colors.white,
                  borderWidth: 0,
                  borderRadius: 0.0),
            ),
            SystemWindowButton(
              text: SystemWindowText(
                  text: "Focus button", fontSize: 12, textColor: Colors.white),
              tag: "focus_button",
              width: 0,
              padding:
                  SystemWindowPadding(left: 10, right: 10, bottom: 10, top: 10),
              height: SystemWindowButton.WRAP_CONTENT,
              decoration: SystemWindowDecoration(
                  startColor: Colors.blueAccent,
                  endColor: Colors.blue,
                  borderWidth: 0,
                  borderRadius: 30.0),
            )
          ],
          padding:
              SystemWindowPadding(left: 16, right: 16, bottom: 12, top: 10),
          decoration: SystemWindowDecoration(startColor: Colors.white),
          buttonsPosition: ButtonPosition.CENTER);
      SystemAlertWindow.updateSystemWindow(
          height: 230,
          header: header,
          body: body,
          footer: footer,
          margin: SystemWindowMargin(left: 8, right: 8, top: 200, bottom: 0),
          gravity: SystemWindowGravity.TOP,
          notificationTitle: "Outgoing Call",
          notificationBody: "+1 646 980 4741",
          prefMode: prefMode,
          backgroundColor: Colors.transparent,
          isDisableClicks: true);
      setState(() {
        _isUpdatedWindow = true;
      });
    } else {
      setState(() {
        _isShowingWindow = false;
        _isUpdatedWindow = false;
      });
      SystemAlertWindow.closeSystemWindow(prefMode: prefMode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('System Alert Window Example App'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('Running on: $_platformVersion\n'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: MaterialButton(
                  onPressed: _showOverlayWindow,
                  textColor: Colors.white,
                  child: !_isShowingWindow
                      ? Text("Show system alert window")
                      : !_isUpdatedWindow
                          ? Text("Update system alert window")
                          : Text("Close system alert window"),
                  color: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                ),
              ),
              TextButton(
                  onPressed: () async {
                    String logFilePath = await SystemAlertWindow.getLogFile;
                    if (logFilePath != null && logFilePath.isNotEmpty) {
                      Share.shareFiles([logFilePath]);
                    } else {
                      print("Path is empty");
                    }
                  },
                  child: Text("Share Log file"))
            ],
          ),
        ),
      ),
    );
  }
}
