import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/profile_screen/profile_screen_views/build_credit_card.dart';
import 'package:shop_app/screens/profile_screen/profile_screen_views/cart_inputs.dart';
import 'package:shop_app/screens/profile_screen/profile_screen_views/save_button.dart';

import '../../services/credit_card_service.dart';

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
          actions: [
            Consumer<PaymentProvider>(
              builder: (context, paymentProvider, child) {
                if (paymentProvider.hasCreditCard) {
                  return IconButton(
                    onPressed: () {
                      paymentProvider.toggleEditButton();
                    },
                    icon: Image(
                      height: 35.sp,
                      width: 35.sp,
                      image: const AssetImage(
                        "assets/icons/profile/edit_credit_card.png",
                      ),
                    ),
                  );
                } else {
                  return SizedBox(width: 8.sp);
                }
              },
            ),
          ],
        ),
        body: Consumer<PaymentProvider>(
          builder: (context, paymentProvider, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  paymentProvider.isEditButtonPressed == false
                      ? AnimatedBuilder(
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
                                      cardHolderName:
                                          paymentProvider.cardHolder,
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
                                        ),
                                        const SizedBox(height: 30),
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
                                      ],
                                    );
                                  } else {
                                    return Column(
                                      children: [
                                        buildCardInputs(
                                          context: context,
                                          cardNumberController: paymentProvider
                                              .cardNumberController,
                                          cardHolderNameController:
                                              paymentProvider
                                                  .cardHolderNameController,
                                        ),

                                        SizedBox(height: 40.sp),

                                        /// #Save Button
                                        buildSaveButton(
                                          onTap: () {
                                            paymentProvider.cardNumber =
                                                paymentProvider
                                                    .cardNumberController.text;
                                            paymentProvider.cardHolder =
                                                paymentProvider
                                                    .cardHolderNameController
                                                    .text;

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
                        )
                      : Column(
                          children: [
                            buildCardInputs(
                              context: context,
                              cardNumberController:
                                  paymentProvider.cardNumberController,
                              cardHolderNameController:
                                  paymentProvider.cardHolderNameController,
                            ),

                            SizedBox(height: 40.sp),

                            /// #Save Button
                            buildSaveButton(
                              onTap: () async {
                                if (paymentProvider.isEditButtonPressed) {
                                  paymentProvider.cardNumber =
                                      paymentProvider.cardNumberController.text;
                                  paymentProvider.cardHolder = paymentProvider
                                      .cardHolderNameController.text;

                                  await paymentProvider.editCreditCard();
                                }
                              },
                            ),
                          ],
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class PaymentProvider extends ChangeNotifier {
  bool _isEditButtonPressed = false;

  bool get isEditButtonPressed => _isEditButtonPressed;

  bool _hasCreditCard = false;

  bool get hasCreditCard => _hasCreditCard;

  final TextEditingController _cardNumberController = TextEditingController();

  TextEditingController get cardNumberController => _cardNumberController;

  final TextEditingController _cardHolderNameController =
      TextEditingController();

  TextEditingController get cardHolderNameController =>
      _cardHolderNameController;

  String _cardNumber = '';

  String get cardNumber => _cardNumber;

  set cardNumber(String value) {
    _cardNumber = value;
    notifyListeners();
  }

  String _cardHolder = '';

  String get cardHolder => _cardHolder;

  set cardHolder(String value) {
    _cardHolder = value;
    notifyListeners();
  }

  set isEditButtonPressed(bool value) {
    _isEditButtonPressed = value;
    notifyListeners();
  }

  Future<void> addCreditCard() async {
    _hasCreditCard = true;
    await CardDatabase.saveCreditCard(_cardHolder, _cardNumber);
    notifyListeners();
  }

  Future<void> editCreditCard() async {
    Map<String, String>? existingCard = await CardDatabase.getCreditCard();

    if (existingCard != null) {
      cardNumber = existingCard['cardNumber'] ?? '';
      cardHolder = existingCard['cardHolder'] ?? '';
    }

    await CardDatabase.saveCreditCard(cardHolder, cardNumber);

    notifyListeners();
  }

  void toggleEditButton() {
    _isEditButtonPressed = !_isEditButtonPressed;
    notifyListeners();
  }
}
