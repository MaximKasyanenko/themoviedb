import 'package:flutter/material.dart';
import 'package:themoviedb/widgets/news_screen/widgets/new_trailer_widget/new_trailer_cell_widget.dart';

class NewTrailerWidget extends StatefulWidget {
  const NewTrailerWidget({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<NewTrailerWidget> createState() => _NewTrailerWidgetState();
}

class _NewTrailerWidgetState extends State<NewTrailerWidget> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: const TextStyle(fontSize: 27),
                ),
              ),
              ElevatedButton(onPressed: () {}, child: const Text('сегодня')),
              const SizedBox(
                width: 30,
              )
            ],
          ),
        ),
        SizedBox(
          height: 310,
          child: Scrollbar(
            trackVisibility: true,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return NewTrailerCellWidget();
              },
            ),
          ),
        ),
      ],
    );
  }
}
