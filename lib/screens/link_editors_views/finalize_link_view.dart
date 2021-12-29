import 'package:atrap_io/services/add_link/add_link_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FinalizeLinkView extends StatelessWidget {
  const FinalizeLinkView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddLinkBloc, AddLinkState>(
      listener: (context, state) {
        debugPrint("AddLinkSuccess sent ${state.toString()}");

        if (state is AddLinkSuccess) {
          Navigator.pop(context);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: SpinKitThreeBounce(
              color: Colors.black,
              size: 15.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Votre lien est en cours de création"),
              ),
              Text("Merci de patienter"),
            ]),
          )
        ],
      ),
    );
  }
}
