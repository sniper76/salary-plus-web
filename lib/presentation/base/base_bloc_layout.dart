import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class BaseBlocLayout<T extends BlocBase<S>, S extends BaseState> extends StatelessWidget {
  final Create<T> create;
  final Widget Function(BuildContext, T, S) builder;
  final Function(BuildContext, S)? listener;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final AppBar? appBar;
  final Widget? endDrawer;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final bool enabledBottomSafeArea;

  const BaseBlocLayout({
    Key? key,
    required this.create,
    required this.builder,
    this.listener,
    this.scaffoldKey,
    this.appBar,
    this.endDrawer,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.enabledBottomSafeArea = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: create,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bloc = context.read<T>();
          return Scaffold(
            key: scaffoldKey,
            appBar: appBar,
            backgroundColor: backgroundColor ?? context.colorScheme.background,
            body: SafeArea(
              bottom: enabledBottomSafeArea,
              child: BlocListener<T, S>(
                bloc: bloc,
                listener: (context, state) {
                  if (state.isLoading) {
                    EasyLoading.show();
                  } else {
                    EasyLoading.dismiss();
                  }

                  if (state.errorToastMessage.isNotEmpty) {
                    EasyLoading.showError(state.errorToastMessage);
                  }

                  if (state.notiToastMessage.isNotEmpty) {
                    EasyLoading.showInfo(state.notiToastMessage);
                  }

                  listener?.call(context, state);
                },
                child: BlocBuilder<T, S>(
                  bloc: bloc,
                  builder: (context, state) {
                    return builder(context, bloc, state);
                  },
                ),
              ),
            ),
            endDrawer: endDrawer,
            floatingActionButton: floatingActionButton,
          );
        },
      ),
    );
  }
}
