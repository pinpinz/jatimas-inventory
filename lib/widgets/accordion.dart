import 'package:flutter/material.dart';

class Accordion extends StatefulWidget {
  final List<AccordionItem> items;
  final bool multiple;

  const Accordion({
    Key? key,
    this.items = const [],
    this.multiple = false,
  }) : super(key: key);

  @override
  State<Accordion> createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  List<bool> _opens = [];

  @override
  void initState() {
    super.initState();

    _opens = List.filled(widget.items.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (panelIndex, isExpanded) {
        setState(() {
          if (!widget.multiple) {
            for (var i = 0; i < _opens.length; i++) {
              if (i != panelIndex) _opens[i] = false;
            }
          }

          _opens[panelIndex] = !isExpanded;
        });
      },
      dividerColor: Colors.white,
      elevation: 0,
      children: [
        ...widget.items
            .asMap()
            .map((i, e) => MapEntry(
                  i,
                  ExpansionPanel(
                    backgroundColor: Colors.blueGrey.withOpacity(0.1),
                    canTapOnHeader: true,
                    isExpanded: _opens[i],
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        dense: true,
                        title: Text(
                          e.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                    body: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                      child: Text(
                        e.description,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ))
            .values
            .toList()
      ],
    );
  }
}

class AccordionItem {
  final String title, description;

  AccordionItem({
    required this.title,
    required this.description,
  });
}
