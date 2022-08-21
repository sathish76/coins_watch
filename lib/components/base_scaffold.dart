import 'package:coin_watch/blocs/network_status/network_status_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({Key? key, required this.body}) : super(key: key);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<NetworkStatusBloc, NetworkStatusState>(
            builder: (context, state) {
              return AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: state.connected
                    ? SizedBox()
                    : Container(
                        height: 20,
                        margin: EdgeInsets.only(top: 40),
                        color: Colors.redAccent[400],
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text("You're offline"),
                      ),
              );
            },
          ),
          body,
        ],
      ),
    );
  }
}
