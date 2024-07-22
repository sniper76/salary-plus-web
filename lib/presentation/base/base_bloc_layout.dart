import 'package:act_web/config/constants.dart';
import 'package:act_web/core/extension/color_extension.dart';
import 'package:act_web/core/extension/context_extension.dart';
import 'package:act_web/presentation/base/base_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BaseBlocLayout<T extends BlocBase<S>, S extends BaseStateMixin> extends StatefulWidget {
  final T Function(BuildContext context) create;
  final PreferredSizeWidget Function(BuildContext, T, S) appBarbuilder;
  final Widget Function(BuildContext, T, S) builder;
  final Function(BuildContext, S)? listener;
  final Widget? endDrawer;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final bool enabledBottomSafeArea;

  const BaseBlocLayout({
    super.key,
    required this.create,
    required this.appBarbuilder,
    required this.builder,
    this.listener,
    this.endDrawer,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.enabledBottomSafeArea = true,
  });

  @override
  BaseBlocLayoutState<T, S> createState() => BaseBlocLayoutState<T, S>();
}

class BaseBlocLayoutState<T extends BlocBase<S>, S extends BaseStateMixin> extends State<BaseBlocLayout<T, S>> {
  OverlayEntry? _overlay;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<T>(
      create: widget.create,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final T bloc = context.read<T>();

          return Scaffold(
            backgroundColor: widget.backgroundColor ?? context.colorScheme.surface,
            body: BlocListener<T, S>(
              bloc: bloc,
              listener: (context, state) {
                if (state.isLoading) {
                  _showLoading(context);
                } else {
                  _hideLoading();
                }

                if (state.errorToastMessage?.isNotEmpty == true) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.errorToastMessage!),
                  ));
                }

                if (state.notiToastMessage?.isNotEmpty == true) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.notiToastMessage!),
                  ));
                }

                widget.listener?.call(context, state);
              },
              child: BlocBuilder<T, S>(
                bloc: bloc,
                builder: (context, state) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final bool isWideScreen = constraints.maxWidth > AppConfig.maxWidth;

                      if (isWideScreen) {
                        return _buildBody(bloc, state, constraints, isWideScreen);
                      } else {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: AppConfig.maxWidth,
                            child: _buildBody(bloc, state, constraints, isWideScreen),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
            endDrawer: widget.endDrawer,
            floatingActionButton: widget.floatingActionButton,
          );
        },
      ),
    );
  }

  Widget _buildBody(T bloc, S state, BoxConstraints constraints, bool isWideScreen) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          shadowColor: Colors.grey.shade200,
          surfaceTintColor: Colors.transparent,
          automaticallyImplyLeading: false,
          backgroundColor: widget.backgroundColor ?? context.colorScheme.surface,
          toolbarHeight: 82.0,
          pinned: true,
          titleSpacing: 0,
          title: widget.appBarbuilder(context, bloc, state),
        ),
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [
                  HexColor.fromHex('#F4F4F4'),
                  Colors.white,
                ],
                stops: const [0.0, 0.1],
              ),
            ),
            padding: isWideScreen
                ? EdgeInsets.symmetric(
                    horizontal: (constraints.maxWidth - AppConfig.maxWidth) / 2,
                  )
                : null,
            child: widget.builder(context, bloc, state),
          ),
        ),
      ],
    );
  }

  void _showLoading(BuildContext context) {
    if (_overlay != null) {
      return;
    }
    _overlay = OverlayEntry(
      builder: (_) => Container(
        color: Colors.black.withOpacity(0.2),
        child: Center(
          child: SpinKitCircle(
            color: context.colorScheme.primary,
            size: 50.0,
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlay!);
  }

  void _hideLoading() {
    _overlay?.remove();
    _overlay = null;
  }
}
