import 'package:flutter/material.dart';
import 'package:hustlesasa_code_challenge/utils/color.dart';
import 'package:hustlesasa_code_challenge/widgets/animated_scale.dart';
import 'package:hustlesasa_code_challenge/widgets/circle_container.dart';

import '../utils/space.dart';

class ConversationsView extends StatelessWidget {
  const ConversationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      itemBuilder: (context, index) {
        final ValueNotifier<bool> isSelected = ValueNotifier(false);

        return ValueListenableBuilder(
            valueListenable: isSelected,
            builder: (context, selected, _) {
              return CustomAnimatedScale(
                onPressed: () {},
                child: Container(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => isSelected.value = !isSelected.value,
                        child: AnimatedContainer(
                          height: 40,
                          width: 40,
                          color: selected ? Colors.green.withOpacity(0.6) : Colors.pink.withOpacity(0.4),
                          duration: const Duration(milliseconds: 400),
                        ),
                      ),
                      kHorizontalSpace12,
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Pedro Pascal',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.800000011920929),
                                    fontSize: 14,
                                    fontFamily: 'GT Walsheim Pro',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  'Today',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontFamily: 'GT Walsheim Pro',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Hi, I would like to know how long it takes to get products delivered to Nairobi, I just ordered the Love Fest & Harmony hood?",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.800000011920929),
                                fontSize: 12,
                                fontFamily: 'GT Walsheim Pro',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                            Row(
                              children: [
                                Spacer(),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: CircleContainer(
                                    color: kPrimaryColor,
                                    padding: EdgeInsets.all(4),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
      separatorBuilder: (context, index) {
        return kVerticalSpace16;
      },
      itemCount: 6,
    );
  }
}
