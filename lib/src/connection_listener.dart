import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internet_connection_listener/internet_connection_listener.dart';
import 'package:internet_connection_listener/src/navigator_service.dart';
import 'package:internet_connection_listener/src/no_internet_page.dart';

class ConnectionListener extends StatefulWidget {
  final Widget child;
   Widget? noInternetWidget;

   ConnectionListener({Key? key, required this.child,this.noInternetWidget}) : super(key: key);

  @override
  State<ConnectionListener> createState() => _ConnectionListenerState();
}

class _ConnectionListenerState extends State<ConnectionListener> {
  late final StreamSubscription<ConnectionStatus> _subscription;
  bool _isDialogShown = false;

  @override
  void initState() {
    super.initState();
    if(widget.noInternetWidget == null){
      widget.noInternetWidget = NoInternetPage();
      setState(() {
        
      });
    }
    _subscription = ConnectionService()
        .connectionStatusStream
        .listen(_handleConnectionChange);
  }

void _handleConnectionChange(ConnectionStatus status) {
  final navigator = NavigatorService.navigator;
  if (navigator == null) return;

  if (status == ConnectionStatus.disconnected && !_isDialogShown) {
    _isDialogShown = true;
    navigator.push(MaterialPageRoute(
      builder: (_) => widget.noInternetWidget!,
    ));
  } else if (status == ConnectionStatus.connected && _isDialogShown) {
    _isDialogShown = false;
    navigator.popUntil((route) => route.isFirst);
  }
}
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

