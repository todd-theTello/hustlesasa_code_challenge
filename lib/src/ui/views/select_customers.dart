import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../states/customers/customer_controller.dart';
import '../../../utils/extensions.dart';
import '../../../utils/space.dart';
import '../theme/text_styles.dart';
import '../widgets/animated_scale.dart';
import '../widgets/text_fields/search_input_decoration.dart';
import 'customers.dart';

///
class SelectCustomersView extends StatefulWidget {
  ///
  const SelectCustomersView({required this.customerController, super.key});
  final CustomerController customerController;

  @override
  State<SelectCustomersView> createState() => _SelectCustomersViewState();
}

class _SelectCustomersViewState extends State<SelectCustomersView> {
  final search = TextEditingController();
  final ValueNotifier<bool> selectAll = ValueNotifier(false);
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

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
              ValueListenableBuilder(
                valueListenable: widget.customerController,
                builder: (context, selected, _) {
                  return Row(
                    children: [
                      Column(
                        children: [
                          Radio(
                            value: selected,
                            groupValue: true,
                            splashRadius: 20,
                            visualDensity: const VisualDensity(vertical: -4),
                            onChanged: (_) {
                              if (selected is CustomerSuccess) {
                                selectAll.value = !selectAll.value;
                                widget.customerController.selectOrDeselectAll(
                                  customers: selected.customer,
                                  isSelect: selectAll.value,
                                );
                              }
                            },
                            toggleable: true,
                          ),
                          Text(
                            'All',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 12,
                              fontFamily: 'GT Walsheim Pro',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                      if (selected is CustomerSuccess)
                        Text(
                          selected.customer.where((element) => element.isSelected).isNotEmpty
                              ? selected.customer.where((element) => element.isSelected).length.toString()
                              : 'Select Customer',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.800000011920929),
                            fontSize: 14,
                            fontFamily: 'GT Walsheim Pro',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      const Spacer(),
                      CustomAnimatedScale(
                        onPressed: () {
                          if (selected is CustomerSuccess) {
                            showDialog<void>(
                              context: context,
                              builder: (_) => DeleteDialog(
                                widget: widget,
                                selected: selected,
                              ),
                            );
                          }
                        },
                        child: Row(
                          children: [
                            Text(
                              'Delete',
                              style: kLabelStyle.copyWith(
                                color: const Color(0xFF00CC99),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            kHorizontalSpace8,
                            const Icon(Icons.delete, color: Color(0xFF00CC99), size: 18)
                          ],
                        ),
                      ),
                      kHorizontalSpace20,
                    ],
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 10.0),
                child: TextField(
                  controller: search,
                  readOnly: true,
                  decoration: kSearchFieldInputDecorator,
                ),
              ),
            ],
          ),
        ),
      ),
      body: CustomersView(
        controller: widget.customerController,
        scrollController: ScrollController(),
        isSelectPage: true,
      ),
    );
  }
}

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({required this.widget, required this.selected, super.key});

  final SelectCustomersView widget;
  final CustomerSuccess selected;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: const Color(0xFFFF3B30).withOpacity(0.2),
                child: SvgPicture.asset('assets/images/caution.svg'),
              ),
              kVerticalSpace16,
              const Text(
                'Delete Selected Customers',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF322644),
                  fontSize: 18,
                  fontFamily: 'GT Walsheim Pro',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              kVerticalSpace12,
              Text('Are you sure you would like to delete the selected customers? This process can’t be undone.',
                  textAlign: TextAlign.center,
                  style: kLabelStyle.copyWith(fontWeight: FontWeight.w500, color: const Color(0xFF626266))),
              kVerticalSpace12,
              Row(
                children: [
                  FilledButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ).expanded,
                  kHorizontalSpace16,
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFFE6E6E6),
                      foregroundColor: const Color(0xFFFF3B30),
                    ),
                    onPressed: () {
                      widget.customerController.deleteSelected(
                        customers: selected.customer,
                      );

                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: const Text('Delete'),
                  ).expanded,
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
