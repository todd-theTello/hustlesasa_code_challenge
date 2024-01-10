import 'dart:math';

import 'package:flutter/material.dart';

import 'src/core/models/customer.dart';
import 'src/core/states/customers/customer_controller.dart';
import 'src/ui/theme/text_styles.dart';
import 'src/ui/views/conversations.dart';
import 'src/ui/views/customers.dart';
import 'src/ui/views/select_customers.dart';
import 'src/ui/widgets/animated_scale.dart';
import 'src/ui/widgets/circle_container.dart';
import 'src/ui/widgets/text_fields/search_input_decoration.dart';
import 'utils/space.dart';

class HustleSasaRoot extends StatefulWidget {
  const HustleSasaRoot({super.key});

  @override
  State<HustleSasaRoot> createState() => _HustleSasaRootState();
}

class _HustleSasaRootState extends State<HustleSasaRoot> with SingleTickerProviderStateMixin {
  late final TabController tabController;
  late final ScrollController customersScroll;
  final search = TextEditingController();
  final ValueNotifier<bool> isCustomer = ValueNotifier(true);
  late final CustomerController customerController;
  @override
  void didChangeDependencies() {
    tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        isCustomer.value = tabController.index == 0;
      });

    customerController = CustomerController()..fetchCustomers();
    // Todo: perform infinite pagination
    customersScroll = ScrollController()..addListener(() {});
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    search.dispose();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: ValueListenableBuilder(
          valueListenable: isCustomer,
          builder: (context, customer, _) {
            if (customer) {
              return ValueListenableBuilder(
                  valueListenable: customerController,
                  builder: (context, data, _) {
                    if (data is CustomerSuccess) {
                      return FloatingActionButton.extended(
                        onPressed: () {
                          customerController
                            ..addCustomer(
                              newCustomer: Customer(
                                id: generateRandomString(12).hashCode,
                                email: generateRandomString(15),
                                firstName: generateRandomString(10),
                                lastName: generateRandomString(12),
                                avatar: generateRandomString(20),
                                isSelected: false,
                              ),
                              oldCustomers: data.customers,
                            )
                            ..value = customerController.value;
                        },
                        label: const Row(children: [Icon(Icons.add), Text('Add')]),
                        extendedPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                        shape: const StadiumBorder(),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  });
            }
            return const SizedBox.shrink();
          }),
      appBar: AppBar(
        toolbarHeight: 62,
        backgroundColor: const Color(0xFFF7F7F7),
        title: Text('Customers'),
        automaticallyImplyLeading: false,
        titleSpacing: 20,
        centerTitle: true,
        actions: [
          ValueListenableBuilder(
              valueListenable: isCustomer,
              builder: (context, customer, _) {
                if (customer) {
                  return CustomAnimatedScale(
                    onPressed: () {
                      Navigator.of(context).push<void>(MaterialPageRoute(
                        builder: (_) => SelectCustomersView(customerController: customerController),
                      ));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: const Icon(Icons.more_horiz_outlined),
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
        ],
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 96),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 10.0),
                child: TextField(
                  controller: search,
                  readOnly: true,
                  onTap: () {},
                  decoration: kSearchFieldInputDecorator,
                ),
              ),
              TabBar(
                controller: tabController,
                tabs: [
                  const Text('Customers'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Conversations'),
                      kHorizontalSpace8,
                      ValueListenableBuilder(
                        valueListenable: isCustomer,
                        builder: (context, customer, _) {
                          return CircleContainer(
                            color: customer ? Colors.black.withOpacity(0.05) : const Color(0xFFEEFEFA),
                            padding: const EdgeInsets.all(8),
                            child: Text('2', style: kLabelStyle.copyWith(fontSize: 12)),
                          );
                        },
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          CustomersView(controller: customerController, scrollController: customersScroll),
          ConversationsView(controller: customerController),
        ],
      ),
    );
  }
}

/// generates a random string with the specified length
String generateRandomString(int length) {
  const charset = 'abcdefghijklmnopqrstuvwxyz';
  final Random random = Random();
  return String.fromCharCodes(Iterable.generate(length, (_) => charset.codeUnitAt(random.nextInt(charset.length))));
}
