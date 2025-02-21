import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartButton extends StatefulWidget {
  const StartButton({super.key});

  @override
  State<StartButton> createState() => _StartButtonState();
}

class _StartButtonState extends State<StartButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isStart = false;

  @override
  void initState() {
    super.initState();
    isStart = globalState.appState.runTime != null;
    _controller = AnimationController(
      vsync: this,
      value: isStart ? 1 : 0,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  handleSwitchStart() {
    if (isStart == globalState.appState.isStart) {
      isStart = !isStart;
      updateController();
      globalState.appController.updateStatus(isStart);
    }
  }

  updateController() {
    if (isStart) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, child) {
        final startButtonSelectorState =
            ref.watch(startButtonSelectorStateProvider);
        if (!startButtonSelectorState.isInit ||
            !startButtonSelectorState.hasProfile) {
          return Container();
        }
        ref.listen(
          runTimeProvider.notifier.select((state) => state.isStart),
          (prev, next) {
            if (next != isStart) {
              isStart = next;
              updateController();
            }
          },
        );
        final textWidth = globalState.measure
                .computeTextSize(
                  Text(
                    other.getTimeDifference(
                      DateTime.now(),
                    ),
                    style: Theme.of(context).textTheme.titleMedium?.toSoftBold,
                  ),
                )
                .width +
            16;
        return AnimatedBuilder(
          animation: _controller.view,
          builder: (_, child) {
            return SizedBox(
              width: 56 + textWidth * _controller.value,
              height: 56,
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  handleSwitchStart();
                },
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      alignment: Alignment.center,
                      child: AnimatedIcon(
                        icon: AnimatedIcons.play_pause,
                        progress: _controller,
                      ),
                    ),
                    Expanded(
                      child: ClipRect(
                        child: OverflowBox(
                          maxWidth: textWidth,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: child!,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          child: child,
        );
      },
      child: Consumer(
        builder: (_, ref, __) {
          final runTime = ref.watch(runTimeProvider);
          final text = other.getTimeText(runTime);
          return Text(
            text,
            style: Theme.of(context).textTheme.titleMedium?.toSoftBold,
          );
        },
      ),
    );
  }
}
