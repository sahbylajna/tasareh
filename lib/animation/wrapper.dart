import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tasareeh/animation/bubbles_view.dart';
import 'package:tasareeh/animation/success_view.dart';
import 'package:tasareeh/animation/initial.dart';
import 'package:tasareeh/helpers/theme.dart';

class MyWidget extends StatelessWidget {
  MyWidget({super.key});
  final AnimatorCtrl ctrl = AnimatorCtrl();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: UploadWrapper(
        animatorCtrl: ctrl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('AaAaAaAaAaAaAaAaAaAaAAaAaAaAaAaAaAaAaAaAaAAaAaAaAaAaAaAaAaAaAaAAaAaAaAaAaAaAaAaAaAaA'),
            ElevatedButton(
              onPressed: () async {
                ctrl.startAnimation?.call();
                await Future.delayed(Duration(seconds: 5));
                ctrl.finishAnimationWithSuccess?.call();
                // ctrl.finishAnimationWithFailure?.call();
              },
              child: Text('save'),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatorCtrl {
  Function()? startAnimation;
  Function()? finishAnimationWithSuccess;
  Function()? finishAnimationWithFailure;
  Function()? actionSuccess;
  Function()? actionFailure;
}

class UploadWrapper extends StatefulWidget {
  final Widget child;
  final AnimatorCtrl animatorCtrl;
  final Function()? okAction;

  const UploadWrapper({super.key, required this.child, required this.animatorCtrl, this.okAction});

  @override
  State<UploadWrapper> createState() => _UploadWrapperState();
}

class _UploadWrapperState extends State<UploadWrapper> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _animationControllerSuccess;
  late Animation<double> _progressAnimation;
  late Animation<double> _cloudOutAnimation;
  late Animation<double> _endOutAnimation;
  Duration animationDuration = Duration(seconds: 10);
  bool isAnimating = false;
  late Timer timer;
  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: animationDuration);
    _animationControllerSuccess = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _progressAnimation = CurvedAnimation(parent: _animationController, curve: Interval(0.0, 0.65));
    _cloudOutAnimation = CurvedAnimation(parent: _animationController, curve: Interval(0.7, 0.95));
    _endOutAnimation = CurvedAnimation(parent: _animationControllerSuccess, curve: Interval(0.1, 1.0));
    widget.animatorCtrl.startAnimation = start;
    widget.animatorCtrl.finishAnimationWithSuccess = stopSuccess;
    widget.animatorCtrl.finishAnimationWithFailure = stopFailure;

    super.initState();
  }

  start() {
    _animationController.duration = animationDuration;
    _animationController.forward();
    setState(() => isAnimating = true);
    // timer = Timer.periodic(Duration(milliseconds: 250), (Timer t) {
    //   if (!_animationController.isAnimating) {
    //     return;
    //   }
    //   animationDuration = Duration(milliseconds: animationDuration.inMilliseconds + 500);
    //   print('new duration: ${animationDuration.inSeconds}');
    //   _animationController.duration = animationDuration;
    //   // if (_animationController.isAnimating) {
    //   _animationController.stop();
    //   _animationController.forward();
    //   // }
    // });
  }

  stopFailure() async {
    _animationController.duration = Duration(milliseconds: 1000);
    await _animationController.reverse();
    setState(() => isAnimating = false);
  }

  stopSuccess() async {
    // timer.cancel();
    print('zvalue ${_animationController.value}');
    if (_animationController.value < 0.95) {
      await _animationController.animateTo(0.85, duration: Duration(milliseconds: 1000));
    } else if (_animationController.value < 0.85) {
      await _animationController.animateTo(0.85, duration: Duration(milliseconds: 1500));
    }
    _animationControllerSuccess.forward();
    setState(() => isAnimating = false);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (isAnimating) Positioned.fill(child: Container(color: appColor.withOpacity(0.5))),
        DataBackupCloudPage(
          progressAnimation: _progressAnimation,
          cloudOutAnimation: _cloudOutAnimation,
        ),
        if (isAnimating)
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Saving ...',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: ProgressCounter(_progressAnimation),
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        DataBackupCompletedPage(
          endingAnimation: _endOutAnimation,
          okAction: widget.okAction,
        ),
      ],
    );
  }
}

class ProgressCounter extends AnimatedWidget {
  ProgressCounter(Animation<double> animation) : super(listenable: animation);
  double get value => (listenable as Animation).value;
  @override
  Widget build(BuildContext context) {
    return Text('${(value * 100).truncate()}%', style: TextStyle(fontSize: 42));
  }
}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// class UploadWrapper extends StatefulWidget {
//   final Widget child;
//   final AnimatorCtrl animatorCtrl;

//   const UploadWrapper({super.key, required this.child, required this.animatorCtrl});

//   @override
//   State<UploadWrapper> createState() => _UploadWrapperState();
// }

// class _UploadWrapperState extends State<UploadWrapper> with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _progressAnimation;
//   late Animation<double> _cloudOutAnimation;
//   late Animation<double> _endOutAnimation;
//   Duration animationDuration = Duration(seconds: 10);
//   late Timer timer;
//   @override
//   void initState() {
//     _animationController = AnimationController(vsync: this, duration: animationDuration);
//     _progressAnimation = CurvedAnimation(parent: _animationController, curve: Interval(0.0, 0.65));
//     _cloudOutAnimation = CurvedAnimation(parent: _animationController, curve: Interval(0.7, 0.95));
//     _endOutAnimation = CurvedAnimation(parent: _animationController, curve: Interval(0.9, 1.0));
//     widget.animatorCtrl.startAnimation = start;
//     widget.animatorCtrl.finishAnimation = () async {
//       // timer.cancel();
//       print('zvalue ${_animationController.value}');
//       if (_animationController.value < 0.95) {
//         await _animationController.animateTo(0.85, duration: Duration(milliseconds: 1000));
//         _animationController.forward();
//       } else if (_animationController.value < 0.85) {
//         await _animationController.animateTo(0.85, duration: Duration(milliseconds: 1500));
//         _animationController.forward();
//       }
//     };

//     super.initState();
//   }

//   start() {
//     _animationController.forward();
//     // timer = Timer.periodic(Duration(milliseconds: 250), (Timer t) {
//     //   if (!_animationController.isAnimating) {
//     //     return;
//     //   }
//     //   animationDuration = Duration(milliseconds: animationDuration.inMilliseconds + 500);
//     //   print('new duration: ${animationDuration.inSeconds}');
//     //   _animationController.duration = animationDuration;
//     //   // if (_animationController.isAnimating) {
//     //   _animationController.stop();
//     //   _animationController.forward();
//     //   // }
//     // });
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: mainBackgroundColor,
//       body: Stack(children: [
//         Initial(
//           progressAnimation: _progressAnimation,
//           child: widget.child,
//         ),
//         DataBackupCloudPage(
//           progressAnimation: _progressAnimation,
//           cloudOutAnimation: _cloudOutAnimation,
//         ),
//         DataBackupCompletedPage(
//           endingAnimation: _endOutAnimation,
//         ),
//       ]),
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//

// class DataBackupHome extends StatefulWidget {
//   @override
//   State<DataBackupHome> createState() => _DataBackupHomeState();
// }

// class _DataBackupHomeState extends State<DataBackupHome> with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _progressAnimation;
//   late Animation<double> _cloudOutAnimation;
//   late Animation<double> _endOutAnimation;
//   @override
//   void initState() {
//     _animationController = AnimationController(vsync: this, duration: Duration(seconds: 7));
//     _progressAnimation = CurvedAnimation(parent: _animationController, curve: Interval(0.0, 0.65));
//     _cloudOutAnimation = CurvedAnimation(parent: _animationController, curve: Interval(0.7, 0.85));
//     _endOutAnimation = CurvedAnimation(parent: _animationController, curve: Interval(0.8, 1.0));
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: mainBackgroundColor,
//       body: Stack(children: [
//         Initial(onAnimationStarted: () => _animationController.forward(), progressAnimation: _progressAnimation),
//         DataBackupCloudPage(progressAnimation: _progressAnimation, cloudOutAnimation: _cloudOutAnimation),
//         DataBackupCompletedPage(endingAnimation: _endOutAnimation),
//       ]),
//     );
//   }
// }
