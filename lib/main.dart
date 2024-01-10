import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hustlesasa_code_challenge/models/customer.dart';
import 'package:hustlesasa_code_challenge/states/customers/customer_controller.dart';
import 'package:hustlesasa_code_challenge/utils/color.dart';
import 'package:hustlesasa_code_challenge/utils/space.dart';
import 'package:hustlesasa_code_challenge/views/conversations.dart';
import 'package:hustlesasa_code_challenge/views/customers.dart';
import 'package:hustlesasa_code_challenge/views/select_customers.dart';
import 'package:hustlesasa_code_challenge/widgets/animated_scale.dart';
import 'package:hustlesasa_code_challenge/widgets/circle_container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00CC99)),
        useMaterial3: true,
      ),
      home: const HustleSasaRoot(),
    );
  }
}

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
                          print('clicked');
                          customerController.addCustomer(
                            newCustomer: Customer(
                              id: Random.secure().toString().length,
                              email: Random.secure().toString(),
                              firstName: Random.secure().toString(),
                              lastName: Random.secure().toString(),
                              avatar: Random.secure().toString(),
                            ),
                            oldCustomers: data.customer,
                          );
                          customerController.value = customerController.value;
                        },
                        label: const Row(children: [Icon(Icons.add), Text('Add')]),
                        isExtended: true,
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
        title: const Text(
          'Customers',
          style: TextStyle(
            color: Color(0xFF322644),
            fontSize: 16,
            fontFamily: 'GT Walsheim Pro',
            fontWeight: FontWeight.w700,
            height: 20,
          ),
        ),
        titleTextStyle: theme.textTheme.headlineMedium?.copyWith(
          height: 22 / 17,
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF322644),
        ),
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
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const SelectCustomersView(),
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
                  decoration: searchFieldInputDecorator,
                ),
              ),
              TabBar(
                controller: tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: kPrimaryColor,
                labelPadding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'GT Walsheim Pro',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
                labelColor: kPrimaryColor,
                unselectedLabelColor: const Color(0xFF626266),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'GT Walsheim Pro',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
                tabs: [
                  const Text('Customers'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Conversations'),
                      kHorizontalSpace8,
                      CircleContainer(
                        color: Colors.black.withOpacity(0.05),
                        padding: const EdgeInsets.all(8),
                        child: const Text(
                          '2',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'GT Walsheim Pro',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
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
          const ConversationsView(),
        ],
      ),
    );
  }
}

InputDecoration searchFieldInputDecorator = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  prefixIcon: const Icon(Icons.search, color: Color(0xFF626266)),
  hintText: 'Search for a customer…',
  hintStyle: const TextStyle(
    color: Color(0xFF626266),
    fontSize: 12,
    fontFamily: 'GT Walsheim Pro',
    fontWeight: FontWeight.w500,
    height: 14 / 12,
  ),
  filled: true,
  fillColor: Colors.white,
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
);
