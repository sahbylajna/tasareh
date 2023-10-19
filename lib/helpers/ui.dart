import 'package:flutter/material.dart';
import 'package:tasareeh/helpers/theme.dart';
import 'package:tasareeh/screens/skeleton.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyLoadingWidget extends StatelessWidget {
  const MyLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitWaveSpinner(
        color: appColor,
        size: 50.0,
      ),
    );
  }
}

class InputLoadingWidget extends StatelessWidget {
  const InputLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitRipple(
        color: appColor, //Colors.blueGrey
        size: 40.0,
      ),
    );
  }
}

class NewsCardSkelton extends StatelessWidget {
  const NewsCardSkelton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Skeleton(height: 120, width: 120),
        const SizedBox(width: defaultPadding),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Skeleton(width: 80),
              const SizedBox(height: defaultPadding / 2),
              const Skeleton(),
              const SizedBox(height: defaultPadding / 2),
              const Skeleton(),
              const SizedBox(height: defaultPadding / 2),
              Row(
                children: const [
                  Expanded(
                    child: Skeleton(),
                  ),
                  SizedBox(width: defaultPadding),
                  Expanded(
                    child: Skeleton(),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

// ListView.separated(
//                 itemCount: 5,
//                 itemBuilder: (context, index) => const NewsCardSkelton(),
//                 separatorBuilder: (context, index) => const SizedBox(height: defaultPadding),
//               )

// Directionality(
//             textDirection: TextDirection.rtl,
//             child: Scaffold(
//               backgroundColor: Colors.grey[200],
//               appBar: AppBar(
//                 title: Center(child: Text('الملف الشخصي')),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.vertical(
//                     bottom: Radius.circular(40.0),
//                   ),
//                 ),
//                 flexibleSpace: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(40.0),
//                       bottomRight: Radius.circular(40.0),
//                     ),
//                     gradient: LinearGradient(
//                       colors: [primaryColor, accentColor], // Start and end colors
//                       begin: Alignment.centerLeft,
//                       end: Alignment.centerRight,
//                     ),
//                   ),
//                 ),
//               ),
//               body: ListView.separated(
//                 itemCount: 5,
//                 itemBuilder: (context, index) => const NewsCardSkelton(),
//                 separatorBuilder: (context, index) => const SizedBox(height: defaultPadding),
//               ),
//             ),
//           )