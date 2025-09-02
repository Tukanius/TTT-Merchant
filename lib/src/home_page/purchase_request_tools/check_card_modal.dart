import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/components/ui/form_textfield.dart';
import 'package:ttt_merchant_flutter/src/home_page/purchase_request_tools/purchase_request_page.dart';

class CheckCardModal extends StatefulWidget {
  const CheckCardModal({super.key});

  @override
  State<CheckCardModal> createState() => _CheckCardModalState();
}

class _CheckCardModalState extends State<CheckCardModal> {
  TextEditingController controller = TextEditingController();
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();

  bool isLoading = false;
  onSubmit() async {
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isLoading = true;
        });
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(
          PurchaseRequestPage.routeName,
          arguments: PurchaseRequestPageArguments(cardNumber: controller.text),
        );
        // if (saveIsUsername == true) {
        //   email = fbkey.currentState?.fields['email']?.value;
        //   _storePhone(email);
        // } else {
        //   secureStorage.deleteAll();
        // }
        // User save = User.fromJson(fbkey.currentState!.value);
        // await Provider.of<UserProvider>(context, listen: false).login(save);
        // // UserProvider().setUsername(save.username.toString());
        // await Provider.of<UserProvider>(context, listen: false).me(true);

        setState(() {
          isLoading = false;
        });
        // await Navigator.of(context).pushNamed(SplashPage.routeName);
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: white50,
      ),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 8),
              Container(
                width: 38,
                height: 4,
                decoration: BoxDecoration(
                  color: black300,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Картын мэдээлэл',
                style: TextStyle(
                  color: black950,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: white,
                  ),
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Хэрэглээний үлдэгдэл:',
                        style: TextStyle(
                          color: black800,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Хэрэглэгчийн картын дугаар оруулна уу.',
                        style: TextStyle(
                          color: black300,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: FormBuilder(
                  key: fbkey,
                  child: FormTextField(
                    controller: controller,
                    contentPadding: EdgeInsets.all(12),
                    dense: true,
                    colortext: black,
                    color: white,
                    name: 'cardNumber',
                    hintTextStyle: TextStyle(
                      color: black500,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    hintText: 'Картын дугаар оруулна уу.',
                    prefixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 12),
                        SvgPicture.asset('assets/svg/edit.svg'),
                        SizedBox(width: 12),
                      ],
                    ),
                    borderRadius: 12,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'Картын дугаар оруулна уу.',
                      ),
                    ]),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        onSubmit();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: orange,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isLoading == true
                                ? Container(
                                    // margin: EdgeInsets.only(right: 15),
                                    width: 17,
                                    height: 17,
                                    child: Platform.isAndroid
                                        ? Center(
                                            child: CircularProgressIndicator(
                                              color: white,
                                              strokeWidth: 2.5,
                                            ),
                                          )
                                        : Center(
                                            child: CupertinoActivityIndicator(
                                              color: white,
                                            ),
                                          ),
                                  )
                                : Text(
                                    'Шалгах',
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
            ],
          ),
        ),
      ),
    );
  }
}
