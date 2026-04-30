// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:loan_sdk_package/app/data/values/images.dart';
// import 'package:loan_sdk_package/app/modules/credit_onboarding/itr/presentation/bloc/itr_bloc.dart';
// import 'package:loan_sdk_package/app/modules/credit_onboarding/itr/presentation/bloc/itr_state.dart';
// import 'package:loan_sdk_package/app/modules/credit_onboarding/itr/presentation/bloc/itr_event.dart';
// import 'package:loan_sdk_package/app/modules/credit_onboarding/presentation/bloc/credit_onboarding_state.dart';
// import 'package:loan_sdk_package/app/themes/styles.dart';
// import 'package:loan_sdk_package/utils/helper/sizedbox_extension.dart';
// import 'package:loan_sdk_package/widgets/input_text_field.dart';
// import '../../../../../../widgets/common_widget.dart';
// import '../../../../../../widgets/custom_button.dart';
// import '../../../../../data/values/strings.dart';
// import '../../../../../route/app_pages.dart';
// import '../../../credit_common_method.dart';
// import '../../../presentation/views/widgets/onboarding_app_bar.dart';
// import '../../../data/models/onboarding_steps_response.dart';
// import '../../../presentation/bloc/credit_onboarding_bloc.dart';
// import '../../../presentation/views/widgets/header_widget.dart';
// import 'package:loan_sdk_package/app/modules/credit_onboarding/presentation/bloc/credit_onboarding_event.dart'
//     as coe;
//
// class ItrView extends StatefulWidget {
//   const ItrView({
//     super.key,
//     required this.profileId,
//     required this.pan,
//     required this.pageId,
//     required this.pageCategory,
//     required this.prevPageId,
//     required this.page,
//   });
//
//   final String profileId;
//   final String pan;
//   final String pageId;
//   final String pageCategory;
//   final String prevPageId;
//   final StepsPage? page;
//
//   @override
//   State<ItrView> createState() => _ItrViewState();
// }
//
// class _ItrViewState extends State<ItrView> {
//   TextEditingController userNameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   final formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     super.initState();
//     init();
//   }
//
//   void init() {
//     userNameController.text = widget.pan.trim();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar:
//       //     CommonWidget().customAppBar(title: "", onBackPressed: onBackPress),
//       appBar: CreditOnboardingAppBar(title: "",onBackPressed: (){
//         CreditCommonMethod.onBackPress(
//           context: context,
//           prevPageId: widget.prevPageId,
//           profileId: widget.profileId,
//         );
//       },),
//       bottomSheet: Wrap(
//         children: [
//           Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: CustomButton(
//                 onTap: () {
//                   FocusManager.instance.primaryFocus?.unfocus();
//                   if ((formKey.currentState?.validate() ?? false)) {
//                     context.read<ItrBloc>().add(
//                           OnContinueTap(
//                             username: userNameController.text.trim(),
//                             password: passwordController.text.trim(),
//                             pageId: widget.pageId,
//                             pageCategory: widget.pageCategory,
//                             profileId: widget.profileId,
//                           ),
//                         );
//                   }
//                 },
//                 buttonText: Strings.continueString,
//               )),
//         ],
//       ),
//       body: bodyWidget(),
//     );
//   }
//
//   Widget bodyWidget() {
//     return WillPopScope(
//       onWillPop: () async {
//         CreditCommonMethod.onBackPress(
//           context: context,
//           prevPageId: widget.prevPageId,
//           profileId: widget.profileId,
//         );
//         return false;
//       },
//       child: BlocListener<CreditOnboardingBloc, CreditOnboardingState>(
//         listener: (context, state) {
//           if (state.userProfileStageUpdated ?? false) {
//             context.replaceNamed(
//               Routes.sdkCreditOnboarding,
//               extra: {
//                 "profileId": widget.profileId,
//               },
//             );
//             context.read<CreditOnboardingBloc>().add(coe.OnReset());
//           }
//         },
//         child: BlocListener<ItrBloc, ItrState>(
//           listener: (context, state) {
//             if (state.dataMap?.isNotEmpty ?? false) {
//               context.read<CreditOnboardingBloc>().add(
//                     coe.OnUpdateUserProfileStage(
//                       data: state.dataMap,
//                       profileId: widget.profileId,
//                     ),
//                   );
//               context.read<ItrBloc>().add(OnReset());
//             }
//           },
//           child: SingleChildScrollView(
//             padding: EdgeInsets.symmetric(
//               vertical: 24,
//               horizontal: 16,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 HeaderWidget(
//                   heading: widget.page?.heading?.title ?? "",
//                   subHeading: widget.page?.heading?.subTitle ?? "",
//                   iconUrl: (widget.page?.heading?.appLogo?.isNotEmpty ?? false)
//                       ? (widget.page?.heading?.appLogo ?? "")
//                       : ((widget.page?.heading?.pageLogo) ?? ""),
//                 ),
//                 48.h,
//                 Text(
//                   Strings.enterYourUsernameAndPassword,
//                   style: Styles.tsBlack3BMedium12(),
//                 ),
//                 12.h,
//                 BlocBuilder<ItrBloc, ItrState>(builder: (context, state) {
//                   return Form(
//                     key: formKey,
//                     autovalidateMode: (state.submitClicked ?? false)
//                         ? AutovalidateMode.onUserInteraction
//                         : null,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         InputTextField(
//                           textFieldWrapper: userNameController,
//                           hintText: Strings.userName,
//                           labelText: Strings.userName,
//                           validator: (val) {
//                             if (val?.isEmpty ?? false) {
//                               return ErrorMessages.thisFieldIsRequired;
//                             }
//                             return null;
//                           },
//                           readOnly: (widget.pan.isNotEmpty),
//                         ),
//                         16.h,
//                         BlocBuilder<ItrBloc, ItrState>(
//                             builder: (context, state) {
//                           return InputTextField(
//                             textFieldWrapper: passwordController,
//                             hintText: Strings.password,
//                             labelText: Strings.password,
//                             validator: (val) {
//                               if (val?.isEmpty ?? false) {
//                                 return ErrorMessages.thisFieldIsRequired;
//                               }
//                               return null;
//                             },
//                             suffix: IconButton(
//                               icon: (state.obscureText ?? false)
//                                   ? Icon(Icons.visibility_off)
//                                   : Icon(Icons.visibility),
//                               onPressed: () {
//                                 context
//                                     .read<ItrBloc>()
//                                     .add(OnUpdateObscureText());
//                               },
//                             ),
//                             obscureText: (state.obscureText ?? false),
//                           );
//                         }),
//                       ],
//                     ),
//                   );
//                 }),
//                 80.h,
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
