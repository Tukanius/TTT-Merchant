// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:honog_flutter/components/ui/color.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';

// class FormTextField extends StatefulWidget {
//   final String name;
//   final TextEditingController? controller;
//   final String? labelText;
//   final String? hintText;
//   final TextInputType inputType;
//   final TextInputAction? inputAction;
//   final InputDecoration? decoration;
//   final String? initialValue;
//   final FocusNode? focus;
//   final FocusNode? nextFocus;
//   final Widget? prefixIcon;
//   final Widget? suffixIcon;
//   final bool obscureText;
//   final bool hasObscureControl;
//   final bool autoFocus;
//   final double? fontSize;
//   final bool readOnly;
//   final FocusNode? focusNode;
//   final FontWeight fontWeight;
//   final int? maxLines;
//   final FocusNode? nextFocusNode;
//   final Function? onComplete;
//   final String? Function(dynamic)? validator;
//   final FormFieldValidator<String>? validators;
//   final String? errorText;
//   final List<TextInputFormatter>? inputFormatters;
//   final TextCapitalization textCapitalization;
//   final int? maxLenght;
//   final bool showCounter;
//   final Function(dynamic)? onChanged;
//   final Color? color;
//   final Color? colortext;
//   final Color? hintTextColor;
//   final TextAlign? textAlign;
//   final Color? labelColor;
//   final Function()? onTap;
//   final Color? borderColor;
//   final bool? dense;
//   final EdgeInsetsGeometry? contentPadding;
//   final double? borderRadius;
//   final Widget? suffix;
//   final BoxConstraints? suffixContraints;
//   final TextStyle? hintTextStyle;

//   const FormTextField({
//     super.key,
//     this.textAlign,
//     required this.name,
//     this.colortext,
//     this.controller,
//     this.decoration,
//     this.maxLines = 1,
//     this.fontWeight = FontWeight.w400,
//     this.hintText,
//     this.fontSize = 14,
//     this.inputType = TextInputType.visiblePassword,
//     this.inputAction,
//     this.initialValue,
//     this.obscureText = false,
//     this.hasObscureControl = false,
//     this.autoFocus = false,
//     this.readOnly = false,
//     this.focusNode,
//     this.nextFocusNode,
//     this.onComplete,
//     this.validator,
//     this.validators,
//     this.inputFormatters,
//     this.textCapitalization = TextCapitalization.none,
//     this.maxLenght,
//     this.showCounter = true,
//     this.errorText,
//     this.onChanged,
//     this.focus,
//     this.nextFocus,
//     this.prefixIcon,
//     this.color,
//     this.suffixIcon,
//     this.hintTextColor,
//     this.labelText,
//     this.labelColor,
//     this.onTap,
//     this.borderColor,
//     this.dense,
//     this.contentPadding,
//     this.borderRadius,
//     this.suffix,
//     this.suffixContraints,
//     this.hintTextStyle,
//   });

//   @override
//   FormTextFieldState createState() => FormTextFieldState();
// }

// class FormTextFieldState extends State<FormTextField> {
//   bool isPasswordVisible = false;

//   @override
//   void initState() {
//     isPasswordVisible = widget.hasObscureControl;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         widget.labelText != null
//             ? Container(
//               margin: EdgeInsets.only(bottom: 5),
//               child: Text(
//                 "${widget.labelText}",
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: widget.labelColor != null ? widget.labelColor : black,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             )
//             : SizedBox(),
//         FormBuilderTextField(
//           onTap: widget.onTap,
//           buildCounter:
//               widget.showCounter
//                   ? null
//                   : (
//                     context, {
//                     int? currentLength,
//                     bool? isFocused,
//                     int? maxLength,
//                   }) => null,
//           controller: widget.controller,
//           autofocus: widget.autoFocus,
//           focusNode: widget.focusNode,
//           maxLines: widget.maxLines,
//           keyboardType: widget.inputType,
//           textInputAction: widget.inputAction,
//           initialValue: widget.initialValue,
//           obscureText:
//               widget.hasObscureControl ? isPasswordVisible : widget.obscureText,
//           readOnly: widget.readOnly,
//           autocorrect: false,
//           // autovalidate: false,
//           // validator: widget.validators ?? [],
//           validator: widget.validators ?? widget.validator,
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           textCapitalization: widget.textCapitalization,
//           inputFormatters: widget.inputFormatters,
//           maxLength: widget.maxLenght,
//           onChanged: widget.onChanged,
//           onEditingComplete: () {
//             if (widget.nextFocusNode != null) {
//               widget.nextFocusNode!.requestFocus();
//             } else {
//               FocusScope.of(context).unfocus();
//             }
//           },
//           onSubmitted: (value) {
//             if (widget.onComplete is Function) {
//               widget.onComplete!();
//             }
//           },
//           textAlign:
//               widget.textAlign != null ? widget.textAlign! : TextAlign.start,
//           style: TextStyle(
//             color: widget.colortext,
//             fontSize: widget.fontSize,
//             fontWeight: widget.fontWeight,
//           ),

//           decoration:
//               widget.decoration ??
//               InputDecoration(
//                 errorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(
//                     widget.borderRadius ?? 320,
//                   ),
//                   borderSide:
//                       widget.borderColor != null
//                           ? BorderSide(color: widget.borderColor!)
//                           : BorderSide.none,
//                 ),
//                 focusedErrorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(
//                     widget.borderRadius ?? 320,
//                   ),
//                   borderSide:
//                       widget.borderColor != null
//                           ? BorderSide(color: widget.borderColor!)
//                           : BorderSide.none,
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(
//                     widget.borderRadius ?? 320,
//                   ),
//                   borderSide:
//                       widget.borderColor != null
//                           ? BorderSide(color: widget.borderColor!)
//                           : BorderSide.none,
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(
//                     widget.borderRadius ?? 320,
//                   ),
//                   borderSide:
//                       widget.borderColor != null
//                           ? BorderSide(color: widget.borderColor!)
//                           : BorderSide.none,
//                 ),
//                 disabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(
//                     widget.borderRadius ?? 320,
//                   ),
//                   borderSide:
//                       widget.borderColor != null
//                           ? BorderSide(color: widget.borderColor!)
//                           : BorderSide.none,
//                 ),
//                 hintText: widget.hintText,
//                 prefixIcon: widget.prefixIcon,
//                 prefixIconConstraints: BoxConstraints(
//                   minWidth: 0,
//                   minHeight: 0,
//                 ),
//                 suffix: widget.suffix ?? null,
//                 suffixIcon: widget.suffixIcon,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(16),
//                   borderSide: BorderSide.none,
//                 ),
//                 contentPadding:
//                     widget.contentPadding != null
//                         ? widget.contentPadding
//                         : const EdgeInsets.only(
//                           left: 15,
//                           right: 15,
//                           top: 15,
//                           bottom: 15,
//                         ),
//                 filled: true,
//                 isDense: widget.dense,
//                 suffixIconConstraints: widget.suffixContraints ?? null,
//                 hintStyle:
//                     widget.hintTextStyle != null
//                         ? widget.hintTextStyle
//                         : TextStyle(
//                           color: widget.hintTextColor ?? gray103,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                 fillColor: widget.color,
//               ),
//           name: widget.name,
//         ),
//       ],
//     );
//   }
// }
