import 'package:coin_watch/blocs/network_status/network_status_bloc.dart';
import 'package:coin_watch/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GlobalKey<NavigatorState> navigatorKey;
  @override
  void initState() {
    navigatorKey = GlobalKey<NavigatorState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NetworkStatusBloc>(
          create: (context) => NetworkStatusBloc()
            ..add(
              NetworkStatusListenerStarted(),
            ),
        )
      ],
      child: MaterialApp(
        title: 'Coin Watch',
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Color(0xFF100F0F),
          backgroundColor: Color(0xFF100F0F),
          primarySwatch: Colors.amber,
        ),
        navigatorKey: navigatorKey,
        initialRoute: Routes.HOME_SCREEN,
        onGenerateRoute: Routes().onGenerate,
      ),
    );
  }
}
