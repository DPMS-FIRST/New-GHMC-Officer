import 'package:flutter/material.dart';
import 'package:ghmc_officer/Res/components/background_image.dart';
import 'package:ghmc_officer/Res/components/logo_details.dart';
import 'package:ghmc_officer/Res/constants/Images/image_constants.dart';

class SliverPersistentAppBar extends StatefulWidget {
  const SliverPersistentAppBar({Key? key}) : super(key: key);

  @override
  State<SliverPersistentAppBar> createState() => _SliverPersistentAppBarState();
}

class _SliverPersistentAppBarState extends State<SliverPersistentAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: MySliverAppBar(expandedHeight: 200.0),
              ),
              
              
              SliverList(
                delegate: SliverChildListDelegate([
                  listCardWidget(text1: 'No of Requests by Citizen', text2: '20'),
                  listCardWidget(text1: 'No of Requests by AMOH', text2: '16'),
                  listCardWidget(text1: 'Payment Confirmation', text2: '8'),
                  listCardWidget(text1: 'Raise Request', text2: ''),
                  listCardWidget(text1: 'Concessioner Rejected', text2: '9'),
                  listCardWidget(text1: 'Concessioner Close Tickets', text2: '34'),
                  listCardWidget(text1: 'AMOH Close Tickets', text2: '2'),
                 
                ]),
              ), 
            ],
          ),
        ));
  }

  Widget listCardWidget({required String text1, required text2}) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black87, width: 1),
      ),
      color: Colors.transparent,
      margin: const EdgeInsets.all(4.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text1,
              style: const TextStyle(fontSize: 14,
              color: Colors.white
              ),
            ),
            Text(
              text2,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.white
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Stack(
            children: [
              BgImage(imgPath: ImageConstants.bg),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Center(
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: const Text(
              'AMOH Dashboard',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
        ),
        Positioned(
          top: expandedHeight / 5 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 4,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Column(
              children: [
                Center(
                  child: Container(
                    child: LogoAndDetails(),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
