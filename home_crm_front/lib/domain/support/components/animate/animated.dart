import 'package:flutter/cupertino.dart';

class AnimatedWrapper extends StatefulWidget {
  final Widget child;
  final AnimationInfo animationInfo;

  const AnimatedWrapper({
    super.key,
    required this.child,
    required this.animationInfo,
  });

  @override
  _AnimatedWrapperState createState() => _AnimatedWrapperState();
}

class _AnimatedWrapperState extends State<AnimatedWrapper>
    with TickerProviderStateMixin {
  late AnimationInfo animationInfo;

  @override
  void initState() {
    super.initState();
    animationInfo = widget.animationInfo;
    animationInfo.initState(this);

    // _controller = AnimationController(
    //   vsync: this,
    //   duration: widget.animationInfo.totalDuration,
    // );
    //
    // // Создание анимаций на основе эффектов
    // if (widget.animationInfo.effects.contains(AnimationEffect.visibility)) {
    //   _opacityAnimation = CurvedAnimation(
    //     parent: _controller,
    //     curve: widget.animationInfo.curve,
    //   );
    // }
    //
    // if (widget.animationInfo.effects.contains(AnimationEffect.fade)) {
    //   _opacityAnimation = CurvedAnimation(
    //     parent: _controller,
    //     curve: widget.animationInfo.curve,
    //   );
    // }
    //
    // if (widget.animationInfo.effects.contains(AnimationEffect.move)) {
    //   _positionAnimation =
    //       Tween<Offset>(
    //         begin: const Offset(0.0, 20.0), // смещение по Y
    //         end: Offset.zero,
    //       ).animate(
    //         CurvedAnimation(
    //           parent: _controller,
    //           curve: widget.animationInfo.curve,
    //         ),
    //       );
    // }
    //
    // if (widget.animationInfo.effects.contains(AnimationEffect.scale)) {
    //   _scaleAnimation =
    //       Tween<double>(
    //         begin: 0.9, // начальный масштаб
    //         end: 1.0,
    //       ).animate(
    //         CurvedAnimation(
    //           parent: _controller,
    //           curve: widget.animationInfo.curve,
    //         ),
    //       );
    // }
  }

  @override
  void dispose() {
    animationInfo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return animationInfo.getAnimation(widget.child);
  }
}

enum AnimationTrigger { onPageLoad, onTap, onDrag, custom }

class AnimationInfo {
  final AnimationTrigger trigger;
  final List<Effect> effects;

  AnimationInfo({required this.trigger, required this.effects});

  Widget getAnimation(Widget children) {
    Widget currentWidget = children;
    for (final effect in effects) {
      currentWidget = effect.getAnimation(currentWidget);
    }
    return currentWidget;
  }

  void initState(TickerProviderStateMixin provider) {
    for (var e in effects) {
      e.initState(provider, trigger);
      switch (trigger) {
        case AnimationTrigger.onPageLoad:
          e.forward(); // запускаем анимацию при загрузке страницы
          break;
        case AnimationTrigger.onTap:
          // добавляем обработчик tap-геста
          break;
        case AnimationTrigger.onDrag:
          // добавляем обработчик drag-геста
          break;
        case AnimationTrigger.custom:
          // используем пользовательский триггер
          break;
      }
    }
  }

  void dispose() {
    for (var e in effects) {
      e.dispose();
    }
  }
}

abstract class Effect {
  late AnimationController _controller;

  void initState(TickerProviderStateMixin provider, AnimationTrigger trigger);

  Widget getAnimation(Widget children);

  void dispose() {
    _controller.dispose();
  }

  void forward() {
    _controller.forward(); // Начинаем анимацию
  }
}

class VisibilityEffect extends Effect {
  final int milliseconds;

  VisibilityEffect({required this.milliseconds});

  @override
  Widget getAnimation(Widget children) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOut,
          ).value,
          child: child,
        );
      },
      child: children, // Виджет, к которому применяются анимации
    );
  }

  @override
  void initState(TickerProviderStateMixin provider, AnimationTrigger trigger) {
    _controller = AnimationController(
      vsync: provider,
      duration: Duration(milliseconds: milliseconds),
    );
  }
}

class MoveEffect extends Effect {
  Curve? curve;
  int? delayMilliseconds;
  final int durationMilliseconds;
  final Offset begin;
  Offset? end;

  MoveEffect({
    this.curve,
    this.delayMilliseconds,
    required this.durationMilliseconds,
    required this.begin,
    this.end,
  }) {
    curve ??= Curves.easeInOut;
    delayMilliseconds ??= 0;
    end ??= Offset.zero;
  }

  @override
  Widget getAnimation(Widget children) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Tween<Offset>(
            begin: begin,
            end: end,
          ).animate(CurvedAnimation(parent: _controller, curve: curve!)).value,
          child: child,
        );
      },
      child: children, // Виджет, к которому применяются анимации
    );
  }

  @override
  void initState(TickerProviderStateMixin provider, AnimationTrigger trigger) {
    _controller = AnimationController(
      vsync: provider,
      duration: Duration(milliseconds: durationMilliseconds),
    );
  }

  @override
  void forward() {
    Future.delayed(Duration(milliseconds: delayMilliseconds!)).then((_) {
      _controller.forward(); // Начинаем анимацию
    });
  }
}

class ScaleEffect extends Effect {
  Curve? curve;
  int? delayMilliseconds;
  final int durationMilliseconds;
  final double begin;
  double? end;

  ScaleEffect({
    this.curve,
    this.delayMilliseconds,
    required this.durationMilliseconds,
    required this.begin,
    this.end,
  }) {
    curve ??= Curves.easeInOut;
    delayMilliseconds ??= 0;
    end ??= 1;
  }

  @override
  Widget getAnimation(Widget children) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: Tween<double>(
            begin: begin,
            end: end,
          ).animate(CurvedAnimation(parent: _controller, curve: curve!)).value,
          child: child,
        );
      },
      child: children, // Виджет, к которому применяются анимации
    );
  }

  @override
  void initState(TickerProviderStateMixin provider, AnimationTrigger trigger) {
    _controller = AnimationController(
      vsync: provider,
      duration: Duration(milliseconds: durationMilliseconds),
    );
  }

  @override
  void forward() {
    Future.delayed(Duration(milliseconds: delayMilliseconds!)).then((_) {
      _controller.forward(); // Начинаем анимацию
    });
  }
}
