import 'package:flutter/material.dart';
import 'package:tasareeh/helpers/theme.dart';

const _duration = Duration(milliseconds: 500);

enum DataBackupState { initial, start, end }

class ProgressCounter extends AnimatedWidget {
  ProgressCounter(Animation<double> animation) : super(listenable: animation);
  double get value => (listenable as Animation).value;
  @override
  Widget build(BuildContext context) {
    return Text('${(value * 100).truncate()}%');
  }
}

// class Initial extends StatefulWidget {
//   final VoidCallback onAnimationStarted;
//   final Animation<double> progressAnimation;

//   const Initial({super.key, required this.onAnimationStarted, required this.progressAnimation});

//   @override
//   State<Initial> createState() => _InitialState();
// }

// class _InitialState extends State<Initial> {
//   DataBackupState _currentState = DataBackupState.initial;
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Expanded(flex: 3, child: Text('Cloud Storage', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22))),
//               if (_currentState == DataBackupState.end)
//                 Expanded(
//                   flex: 2,
//                   child: TweenAnimationBuilder(
//                     tween: Tween(begin: 1.0, end: 1.0),
//                     duration: _duration,
//                     builder: (context, value, child) {
//                       return Opacity(opacity: value, child: child);
//                     },
//                     child: Column(
//                       children: [
//                         Text(
//                           'uploading files',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w300),
//                         ),
//                         SizedBox(height: 10),
//                         Expanded(
//                           child: FittedBox(
//                             child: Padding(
//                               padding: const EdgeInsets.only(bottom: 20.0),
//                               child: ProgressCounter(widget.progressAnimation),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               if (_currentState != DataBackupState.end)
//                 Expanded(
//                   flex: 2,
//                   child: TweenAnimationBuilder(
//                     tween: Tween(begin: 1.0, end: _currentState != DataBackupState.initial ? 0.0 : 1.0),
//                     duration: _duration,
//                     onEnd: () => setState(() => _currentState = DataBackupState.end),
//                     builder: (context, value, child) {
//                       return Opacity(
//                         opacity: value,
//                         child: Transform.translate(
//                           offset: Offset(0, 50 * value),
//                           child: child,
//                         ),
//                       );
//                     },
//                     child: Column(children: [Text('last backup:'), Text('28 may 2020')]),
//                   ),
//                 ),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 child: AnimatedSwitcher(
//                   duration: _duration,
//                   child: _currentState == DataBackupState.initial
//                       ? ElevatedButton(
//                           onPressed: () {
//                             setState(() => _currentState = DataBackupState.start);
//                             widget.onAnimationStarted();
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.all(20.0),
//                             child: Text('Create Backup', style: TextStyle(color: Colors.white)),
//                           ),
//                         )
//                       : OutlinedButton(
//                           onPressed: null,
//                           child: const Padding(
//                             padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
//                             child: Text('Cancel', style: TextStyle(color: appColor)),
//                           ),
//                         ),
//                 ),
//               ),
//               const SizedBox(height: 25),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class Initial extends StatefulWidget {
  final Widget child;
  final Animation<double> progressAnimation;

  const Initial({super.key, required this.child, required this.progressAnimation});

  @override
  State<Initial> createState() => _InitialState();
}

class _InitialState extends State<Initial> {
  DataBackupState _currentState = DataBackupState.initial;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 1.0, end: _currentState != DataBackupState.initial ? 0.0 : 1.0),
      duration: _duration,
      onEnd: () => setState(() => _currentState = DataBackupState.end),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, value),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
