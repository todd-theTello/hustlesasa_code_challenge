import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hustlesasa_code_challenge/states/customers/customer_controller.dart';
import 'package:hustlesasa_code_challenge/utils/color.dart';
import 'package:hustlesasa_code_challenge/utils/space.dart';
import 'package:hustlesasa_code_challenge/views/messages.dart';
import 'package:hustlesasa_code_challenge/widgets/animated_scale.dart';

class CustomersView extends StatelessWidget {
  const CustomersView({required this.controller, required this.scrollController, super.key});
  final CustomerController controller;
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.fetchCustomers();
      },
      child: ValueListenableBuilder(
          valueListenable: controller,
          builder: (context, value, _) {
            if (value is CustomerLoading)
              return const SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 80),
                child: CircularProgressIndicator.adaptive(),
              );
            if (value is CustomerSuccess) {
              return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                controller: scrollController,
                itemBuilder: (context, index) {
                  final ValueNotifier<bool> isSelected = ValueNotifier(false);
                  final data = value.customer[index];
                  return ValueListenableBuilder(
                      valueListenable: isSelected,
                      builder: (context, selected, _) {
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x14212026),
                                blurRadius: 12,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              ),
                              BoxShadow(
                                color: Color(0x14212026),
                                blurRadius: 2,
                                offset: Offset(0, 0),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: GestureDetector(
                                  onTap: () => isSelected.value = !isSelected.value,
                                  child: selected
                                      ? Container(
                                          height: 40,
                                          width: 40,
                                          color: kPrimaryColor,
                                          child: const Icon(Icons.check, color: Colors.white),
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: data.avatar,
                                          height: 40,
                                          width: 40,
                                          errorWidget: (context, error, _) {
                                            return Container(
                                              height: 40,
                                              width: 40,
                                              color: Colors.pink.withOpacity(0.4),
                                            );
                                          },
                                        ),
                                ),
                              ),
                              kHorizontalSpace12,
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      '${data.firstName} ${data.lastName}',
                                      style: const TextStyle(
                                          color: Color(0xFF322644),
                                          fontSize: 14,
                                          fontFamily: 'GT Walsheim Pro',
                                          fontWeight: FontWeight.w700,
                                          height: 16 / 14),
                                    ),
                                    kVerticalSpace6,
                                    const Text(
                                      '29 orders',
                                      style: TextStyle(
                                        color: Color(0xFF626266),
                                        fontSize: 12,
                                        fontFamily: 'GT Walsheim Pro',
                                        fontWeight: FontWeight.w500,
                                        height: 14 / 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              CustomAnimatedScale(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => const MessageView(),
                                  ));
                                },
                                child: Column(
                                  children: [
                                    SvgPicture.asset('assets/images/send.svg'),
                                    const Text(
                                      'Message',
                                      style: TextStyle(
                                        color: Color(0x9900CC99),
                                        fontSize: 10,
                                        fontFamily: 'GT Walsheim Pro',
                                        fontWeight: FontWeight.w500,
                                        height: 12 / 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              kHorizontalSpace16,
                              Column(
                                children: [
                                  SvgPicture.asset('assets/images/info.svg'),
                                  const Text(
                                    'Info',
                                    style: TextStyle(
                                      color: Color(0x993984FF),
                                      fontSize: 10,
                                      fontFamily: 'GT Walsheim Pro',
                                      fontWeight: FontWeight.w500,
                                      height: 12 / 10,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      });
                },
                separatorBuilder: (context, index) {
                  return kVerticalSpace16;
                },
                itemCount: value.customer.length,
              );
            }
            if (value is CustomerFailure) {
              return Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
                  child: Text(value.error),
                ),
              );
            } else {
              return const Text('Fuck them kids bro');
            }
          }),
    );
  }
}
