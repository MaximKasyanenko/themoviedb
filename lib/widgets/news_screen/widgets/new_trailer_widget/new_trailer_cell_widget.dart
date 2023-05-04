import 'package:flutter/material.dart';

class NewTrailerCellWidget extends StatelessWidget {
  const NewTrailerCellWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: screenSize.width - 46,
        // color: Colors.grey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 250,
              width: screenSize.width - 46,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white38, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Stack(children: [
                Image.asset(
                  'images/avatar.jpeg',
                  width: screenSize.width - 46,
                  fit: BoxFit.fill,
                ),
                const Center(
                  child: Icon(
                    Icons.play_circle_outlined,
                    size: 50,
                  ),
                )
              ]),
            ),
            Text(
              'iskjhd;ashdfsa',
              maxLines: 2,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Expanded(child: Text('info', maxLines: 1))
          ],
        ),
      ),
    );
  }
}
