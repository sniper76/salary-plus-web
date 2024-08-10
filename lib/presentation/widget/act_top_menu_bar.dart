import 'package:act_cms/config/constants.dart';
import 'package:act_cms/config/theme.dart';
import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/icons/menu_icons.dart';
import 'package:act_cms/presentation/screen/cms_main/widget/logo.dart';
import 'package:act_cms/presentation/screen/cms_main/widget/user_profile.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TopMenuRoute {
  final String title;
  final PageRouteInfo? route;
  final IconData? icon;
  final String? path;
  final List<TopMenuRoute>? subItems;

  TopMenuRoute({
    required this.title,
    this.route,
    this.icon,
    this.path,
    this.subItems,
  });
}

class ActTopMenuBar extends StatefulWidget {
  final User? user;
  final List<TopMenuRoute> routes;
  final void Function()? onLogout;
  final void Function()? onSetLocale;

  const ActTopMenuBar({
    super.key,
    required this.routes,
    this.user,
    this.onLogout,
    this.onSetLocale,
  });

  @override
  State<ActTopMenuBar> createState() => _ActTopMenuBarState();
}

class _ActTopMenuBarState extends State<ActTopMenuBar> {
  final Map<String, bool> _selectedToggleMenuList = {};
  bool _isStockSubItemsVisible = false;

  _launchAppDownload() async {
    await launch(AppConfig.downloadUrl);
  }

  _handleSubItemMenu(String title) {
    setState(() {
      _isStockSubItemsVisible = !_isStockSubItemsVisible;
      if (_selectedToggleMenuList.containsKey(title)) {
        _selectedToggleMenuList.remove(title);
      } else {
        _selectedToggleMenuList[title] = true;
      }
    });
  }

  bool _checkCurrentActiveMenu(String? path) {
    final lastPath = context.router.currentPath.split('/').last;
    return lastPath == path;
  }

  Color _getActiveColor(bool isActive) =>
      isActive ? Colors.white : AppTheme.primaryColor[300] ?? const Color(0xff869DF2);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.primaryColor[600],
      height: 100, // 고정된 높이
      child: SingleChildScrollView( // 스크롤 가능하도록 수정
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Logo(onTap: _launchAppDownload),
                ..._buildMenuItems(routes: widget.routes),
                const Spacer(),
                if (widget.user != null)
                  UserProfile(
                    user: widget.user!,
                    onLogout: widget.onLogout,
                    onSetLocale: widget.onSetLocale,
                  ),
                const SizedBox(width: 25),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildMenuItems({required List<TopMenuRoute> routes, double gap = 50}) {
    List<Widget> menuItems = [];
    for (final route in routes) {
      bool isOpen = _selectedToggleMenuList.containsKey(route.title);
      final subItems = route.subItems ?? [];
      menuItems.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildItem(
              title: route.title,
              icon: route.icon ?? CustomMenuIcons.subline,
              path: route.path,
              gap: gap,
              onTap: () {
                if (route.path != null) {
                  setState(() {
                    context.router.replaceAll([route.route!]);
                  });
                } else {
                  _handleSubItemMenu(route.title);
                }
              },
              trailing: subItems.isNotEmpty ? _buildArrowIcon(isActive: isOpen) : null,
            ),
            if (subItems.isNotEmpty && isOpen)
              Padding(
                padding: const EdgeInsets.only(left: 20), // 상위 메뉴와 구분되는 약간의 패딩 추가
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildSubMenuItems(routes: subItems, gap: gap + 20),
                ),
              ),
          ],
        ),
      );
    }
    return menuItems;
  }

  List<Widget> _buildSubMenuItems({required List<TopMenuRoute> routes, double gap = 50}) {
    return routes.map((route) {
      return _buildSubItem(
        title: route.title,
        icon: route.icon ?? CustomMenuIcons.subline,
        path: route.path,
        gap: gap,
        onTap: () {
          if (route.path != null) {
            setState(() {
              context.router.replaceAll([route.route!]);
            });
          }
        },
        trailing: null,
      );
    }).toList();
  }

  Widget _buildBaseBuilder({
    required Widget child,
    void Function()? onTap,
  }) {
    return StatefulBuilder(builder: (context, setState) {
      bool isHovered = false;

      return InkWell(
        onTap: onTap,
        onHover: (value) {
          setState(() {
            isHovered = value;
          });
        },
        child: Container(
          height: 50,
          color: isHovered ? const Color(0xff3A5ACA) : null,
          child: child,
        ),
      );
    });
  }

  Widget _buildItem({
    required String title,
    required IconData icon,
    void Function()? onTap,
    String? path,
    required double gap,
    Widget? trailing,
  }) {
    return _buildBaseBuilder(
      onTap: onTap,
      child: Stack(
        children: [
          Row(
            children: [
              SizedBox(width: gap),
              _buildIcon(icon: icon, isActive: _checkCurrentActiveMenu(path)),
              const SizedBox(width: 40),
              _buildText(title: title, isActive: _checkCurrentActiveMenu(path)),
            ],
          ),
          if (trailing != null) Positioned(right: 60, child: trailing),
        ],
      ),
    );
  }

  Widget _buildSubItem({
    required String title,
    required IconData icon,
    void Function()? onTap,
    String? path,
    required double gap,
    Widget? trailing,
  }) {
    return _buildBaseBuilder(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(width: gap),
          _buildIcon(icon: icon, isActive: _checkCurrentActiveMenu(path)),
          const SizedBox(width: 40),
          _buildText(title: title, isActive: _checkCurrentActiveMenu(path)),
        ],
      ),
    );
  }

  Widget _buildText({required String title, required bool isActive}) {
    return Text(
      title,
      style: TextStyle(color: _getActiveColor(isActive), fontSize: 18),
    );
  }

  Widget _buildIcon({required IconData icon, required bool isActive}) {
    return Icon(
      icon,
      color: _getActiveColor(isActive),
    );
  }

  Widget _buildArrowIcon({required bool isActive}) {
    return Transform.rotate(
      angle: isActive ? 3.14159 : 0,
      child: const Icon(Icons.keyboard_arrow_down, color: Color(0xff869DF2)),
    );
  }
}
