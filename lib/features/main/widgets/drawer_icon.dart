import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerIcon extends StatefulWidget {
  const DrawerIcon({super.key});

  @override
  State<DrawerIcon> createState() => _DrawerIconState();
}

class _DrawerIconState extends State<DrawerIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCollapsed = context.watch<DrawerIconCubit>().state;
    return WillPopScope(
      onWillPop: () async {
        if (!isCollapsed) {
          _controller.reverse();
          context
              .read<DrawerIconCubit>()
              .changeState(isCollapsed: !isCollapsed);
          return false;
        } else {
          return true;
        }
      },
      child: IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _controller,
        ),
        onPressed: () {
          if (isCollapsed) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
          context
              .read<DrawerIconCubit>()
              .changeState(isCollapsed: !isCollapsed);
        },
      ),
    );
  }
}

class DrawerIconCubit extends Cubit<bool> {
  DrawerIconCubit() : super(true);
  void changeState({required bool isCollapsed}) {
    emit(isCollapsed);
  }
}
