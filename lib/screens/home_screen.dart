import 'package:coin_watch/blocs/asset_list/asset_list_bloc.dart';
import 'package:coin_watch/components/base_scaffold.dart';
import 'package:coin_watch/utils/extensions.dart';
import 'package:coin_watch/components/asset_detail_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 40,
              ),
              Center(
                  child: Text(
                'Coins Watch',
                style: context.textTheme.headlineSmall,
              )),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Hello, Sathish 👋',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Assets',
                style: context.textTheme.headlineSmall,
              ),
              BlocBuilder<AssetListBloc, AssetListState>(
                builder: (context, AssetListState state) {
                  if (state.isSuccess &&
                      state.assets != null &&
                      state.assets!.isNotEmpty) {
                    return ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.assets!.length,
                      itemBuilder: (context, position) {
                        return AssetDetailRow(asset: state.assets![position]);
                      },
                    );
                  } else if (state.isFailure) {
                    return Text('Something went wrong');
                  } else {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
