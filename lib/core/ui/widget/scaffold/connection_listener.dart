import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/snackbar.dart';
import 'package:kod_sozluk_mobile/viewmodel/connectivity_controller.dart';

class ConnectivityListener extends StatelessWidget {
  final Widget child;

  const ConnectivityListener({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityController, NetworkState>(
      listener: (context, state) {
        if (state is ConnectionFailure) {
          AppSnackBar.showSnackBar(message: LocaleKeys.internet_disconnected.locale, type: SnackBarType.ERROR);
        } else if (state is ConnectionSuccess) {
          AppSnackBar.showSnackBar(message: LocaleKeys.reconnected.locale, type: SnackBarType.SUCCESS);
        }
      },
      child: child,
    );
  }
}
