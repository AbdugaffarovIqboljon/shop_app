import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/payment_provider.dart';
import 'package:shop_app/screens/profile_screen/profile_screen_views/build_credit_card.dart';
import 'package:shop_app/screens/profile_screen/profile_screen_views/cart_inputs.dart';
import 'package:shop_app/screens/profile_screen/profile_screen_views/save_button.dart';

import '../../data/services/database/credit_card_database.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PaymentProvider(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          scrolledUnderElevation: 0,
          title: Text(
            "Payment",
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Consumer<PaymentProvider>(
          builder: (context, paymentProvider, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    AnimatedBuilder(
                      animation: _rotationAnimation,
                      builder: (context, child) {
                        return Transform(
                          transform: Matrix4.rotationY(
                            2 * _rotationAnimation.value * pi,
                          ),
                          alignment: Alignment.center,
                          child: FutureBuilder<Map<String, String>?>(
                            future: CardDatabase.getCreditCard(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return ShowCreditCard(
                                  cardNumber: paymentProvider.cardNumber,
                                  cardHolderName: paymentProvider.cardHolder,
                                  onPressed: () {},
                                );
                              }

                              if (snapshot.hasData) {
                                return Column(
                                  children: [
                                    ShowCreditCard(
                                      cardNumber:
                                          snapshot.data!['cardNumber'] ??
                                              'No Data',
                                      cardHolderName:
                                          snapshot.data!['cardHolder'] ??
                                              'No Data',
                                      onPressed: () {
                                        paymentProvider.toggleEditButton();
                                      },
                                    ),
                                    const SizedBox(height: 30),
                                    paymentProvider.isEditButtonPressed == true
                                        ? Column(
                                            children: [
                                              buildCardInputs(
                                                context: context,
                                                cardNumberController:
                                                    paymentProvider
                                                        .cardNumberController,
                                                cardHolderNameController:
                                                    paymentProvider
                                                        .cardHolderNameController,
                                              ),
                                              const SizedBox(height: 20),
                                              buildSaveButton(
                                                onTap: () {
                                                  paymentProvider.cardNumber =
                                                      paymentProvider
                                                          .cardNumberController
                                                          .text;
                                                  paymentProvider.cardHolder =
                                                      paymentProvider
                                                          .cardHolderNameController
                                                          .text;

                                                  paymentProvider
                                                              .cardHolderNameController
                                                              .text
                                                              .isNotEmpty &&
                                                          paymentProvider
                                                              .cardNumberController
                                                              .text
                                                              .isNotEmpty
                                                      ? _controller
                                                          .forward(from: 0)
                                                          .whenComplete(
                                                          () {
                                                            paymentProvider
                                                                .addCreditCard();
                                                          },
                                                        )
                                                      : null;
                                                },
                                              ),
                                            ],
                                          )
                                        : const SizedBox.shrink(),
                                    const SizedBox(height: 20),
                                    Text(
                                      "Or with Cash On Delivery",
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        color: Colors.deepPurple.shade700,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    SizedBox(height: 40.sp),
                                    Image(
                                      height: 250.sp,
                                      image: const AssetImage(
                                        "assets/images/cash-on-delivery.png",
                                      ),
                                    ),
                                    const SizedBox(height: 35),
                                  ],
                                );
                              } else {
                                return Column(
                                  children: [
                                    buildCardInputs(
                                      context: context,
                                      cardNumberController:
                                          paymentProvider.cardNumberController,
                                      cardHolderNameController: paymentProvider
                                          .cardHolderNameController,
                                    ),

                                    SizedBox(height: 40.sp),

                                    /// #Save Initial Button
                                    buildSaveButton(
                                      onTap: () {
                                        paymentProvider.cardNumber =
                                            paymentProvider
                                                .cardNumberController.text;
                                        paymentProvider.cardHolder =
                                            paymentProvider
                                                .cardHolderNameController.text;

                                        _controller
                                            .forward(from: 0)
                                            .whenComplete(() {
                                          paymentProvider.addCreditCard();
                                        });
                                      },
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
