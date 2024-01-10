import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../models/customer.dart';
import '../../../states/customers/customer_controller.dart';
import '../../../utils/color.dart';
import '../../../utils/space.dart';
import '../theme/text_styles.dart';
import '../widgets/animated_scale.dart';
import 'messages.dart';

class CustomersView extends StatelessWidget {
  const CustomersView({required this.controller, required this.scrollController, this.isSelectPage = false, super.key});
  final CustomerController controller;
  final ScrollController scrollController;
  final bool isSelectPage;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.fetchCustomers();
      },
      child: ValueListenableBuilder(
          valueListenable: controller,
          builder: (context, value, _) {
            if (value is CustomerLoading) {
              return const SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 80),
                child: Center(child: SizedBox(height: 24, width: 24, child: CircularProgressIndicator.adaptive())),
              );
            }
            if (value is CustomerSuccess) {
              return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                controller: scrollController,
                itemBuilder: (context, index) {
                  final data = value.customer[index];
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(color: Color(0x14212026), blurRadius: 12, offset: Offset(0, 4)),
                        BoxShadow(color: Color(0x14212026), blurRadius: 2)
                      ],
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (isSelectPage) {
                              controller.selectCustomer(selectedCustomer: data, customers: value.customer);
                            }
                          },
                          child: ImageWidget(
                            data: data,
                            isSelectPage: isSelectPage,
                          ),
                        ),
                        kHorizontalSpace12,
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text('${data.firstName} ${data.lastName}',
                                  maxLines: 2, overflow: TextOverflow.ellipsis, style: kCardHeader),
                              kVerticalSpace6,
                              Text('29 orders', style: kCardContent.copyWith(fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                        CustomAnimatedScale(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const MessageView(),
                            ));
                          },
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                SvgPicture.asset('assets/images/send.svg'),
                                Text(
                                  'Message',
                                  style: kCardTimeStamp.copyWith(
                                    color: const Color(0x9900CC99),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        kHorizontalSpace16,
                        Column(
                          children: [
                            SvgPicture.asset('assets/images/info.svg'),
                            Text(
                              'Info',
                              style: kCardTimeStamp.copyWith(
                                color: const Color(0x993984FF),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
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
              return const Text('Something went wrong');
            }
          }),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key, required this.data, this.isSelectPage = false});

  final Customer data;
  final bool isSelectPage;

  @override
  Widget build(BuildContext context) {
    Color generateRandomColor() {
      final Random random = Random();
      return Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      );
    }

    final color = generateRandomColor();

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: data.isSelected && isSelectPage
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
                  color: color.withOpacity(0.4),
                  child: Center(
                    child: Text(
                      data.firstName.substring(0, 1) + data.firstName.substring(0, 1),
                      style: kLabelStyle.copyWith(color: color, fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
