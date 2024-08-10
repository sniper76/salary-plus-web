import 'dart:io';

import 'package:act_cms/config/constants.dart';
import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/splash/bloc/splash_bloc.dart';
import 'package:act_cms/presentation/widget/app_rounded_button.dart';
import 'package:act_cms/presentation/widget/dev_badge.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _splashLoadingDuration = const Duration(milliseconds: 2500);
  AnimationController? _animationController;
  bool _isAnimationEnded = false;
  bool _showStartButton = false;

  _initialize() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final bloc = _scaffoldKey.currentContext?.read<SplashBloc>();
    if (bloc == null) return;

    bloc.add(SplashEvent.initial());
  }

  _handleAnimation() {
    if (_animationController?.isCompleted == true) {
      if (!_isAnimationEnded) {
        Future.delayed(const Duration(milliseconds: 400), () {
          if (!_isAnimationEnded) {
            _animationController?.forward(from: 0.03);
          }
        });
      }
    }
    setState(() {
      _showStartButton = _isAnimationEnded && (_animationController?.value ?? 0) >= 0.8;
    });
  }

  _onEndSplashAnimation() async {
    _isAnimationEnded = true;
  }

  _showDisableApiDialog() async {
    await context.showAlertDialog(
      title: '서버접속 오류',
      message: '서버접속이 원활하지 않습니다\n앱을 다시 실행해주세요',
    );
    Future.delayed(const Duration(milliseconds: 100), () => exit(0));
  }

  _onStartPressed() {
    if (AppConfig.skipLogin) {
      context.router.replaceNamed('/main');
    } else {
      context.router.replaceNamed('/login');
    }
  }

  _checkingNewVersionAfterNavigate(String path) async {
    context.router.replaceNamed(path);
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    _animationController = AnimationController(
      duration: _splashLoadingDuration,
      vsync: this,
    );
    _animationController?.addListener(_handleAnimation);
    _animationController?.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

  @override
  void dispose() {
    _animationController?.stop();
    _animationController?.removeListener(_handleAnimation);
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<SplashBloc, SplashState>(
      scaffoldKey: _scaffoldKey,
      backgroundColor: context.colorScheme.primary,
      create: (_) => SplashBloc(),
      listener: (context, state) {
        if (state.onNavigateRouteName?.isNotEmpty == true) {
          _checkingNewVersionAfterNavigate(state.onNavigateRouteName!);
        }

        if (state.isCompleted) {
          _onEndSplashAnimation();
        }

        if (!state.enableApiServer) {
          _showDisableApiDialog();
        }
      },
      builder: (context, bloc, state) {
        return Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipPath(
                clipper: WaveClipperTwo(reverse: true, flip: true),
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      const Color(0xff1D19CE).withOpacity(0.4),
                      const Color(0xff1E2FCD).withOpacity(0.32),
                    ],
                    stops: const [0, 0.5],
                  )),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipPath(
                clipper: WaveClipperTwo(reverse: true),
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      const Color(0xff1B96DB).withOpacity(0.4),
                      const Color(0xff2E98C6).withOpacity(0.32),
                    ],
                    stops: const [0, 0.5],
                  )),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/logo.svg',
                    semanticsLabel: 'act app log',
                    fit: BoxFit.cover,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(height: 26),
                  AnimatedOpacity(
                    opacity: _showStartButton ? 1 : 0,
                    duration: AnimationDuration.medium,
                    child: Wrap(
                      direction: Axis.vertical,
                      children: [
                        Text(
                          '인증 기반 주주행동 플랫폼',
                          style: context.textTheme.bodyLarge?.copyWith(color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 110),
                          child: AppRoundedButton(
                            text: 'CMS 시작하기',
                            textStyle: context.textTheme.displayLarge?.copyWith(color: Colors.white),
                            backgroundColor: Colors.transparent,
                            onPressed: _onStartPressed,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (!isRelease)
              const Positioned(
                left: 0,
                right: 0,
                bottom: 20,
                child: Center(
                  child: DevBadge(),
                ),
              ),
          ],
        );
      },
    );
  }
}
