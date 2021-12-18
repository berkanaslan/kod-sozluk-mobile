import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_theme.dart';
import 'package:kod_sozluk_mobile/viewmodel/connectivity_view_model.dart';

class ConnectivityListener extends StatelessWidget {
  final Widget child;

  const ConnectivityListener({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityViewModel, NetworkState>(
      listener: (context, state) {
        if (state is ConnectionFailure) {
          context.showSnackBar(
              message: LocaleKeys.internet_disconnected.locale,
              type: MessageType.Error);
        } else if (state is ConnectionSuccess) {
          context.showSnackBar(
              message: LocaleKeys.reconnected.locale,
              type: MessageType.Success);
        }
      },
      child: child,
    );
  }
}
