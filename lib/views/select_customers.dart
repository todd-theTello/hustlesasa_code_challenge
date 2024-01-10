import 'package:flutter/material.dart';

import '../main.dart';

///
class SelectCustomersView extends StatefulWidget {
  ///
  const SelectCustomersView({super.key});

  @override
  State<SelectCustomersView> createState() => _SelectCustomersViewState();
}

class _SelectCustomersViewState extends State<SelectCustomersView> {
  final search = TextEditingController();
  final ValueNotifier<bool> selectAll = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F7),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 100),
          child: Column(
            children: [
              Row(
                children: [
                  ValueListenableBuilder(
                    valueListenable: selectAll,
                    builder: (context, selected, _) {
                      return Column(
                        children: [
                          Radio(
                            value: selected,
                            groupValue: true,
                            splashRadius: 20,
                            visualDensity: VisualDensity(vertical: -4),
                            onChanged: (_) {
                              selectAll.value = !selectAll.value;
                            },
                            toggleable: true,
                          ),
                          const Text('All'),
                        ],
                      );
                    },
                  ),
                  const Text('Select Customer'),
                  const Spacer(),
                  const Row(
                    children: [
                      Text('Delete'),
                      Icon(Icons.delete),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 10.0),
                child: TextField(
                  controller: search,
                  readOnly: true,
                  onTap: () {},
                  decoration: searchFieldInputDecorator,
                ),
              ),
            ],
          ),
        ),
      ),
      // body: const CustomersView(),
    );
  }
}
