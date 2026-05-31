import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_sdk_package/app/bloc/app_bloc.dart';
import 'package:loan_sdk_package/app/bloc/app_event.dart';
import 'package:loan_sdk_package/app/bloc/app_state.dart';
import 'package:loan_sdk_package/app/data/models/request/sdk_request.dart';
import 'package:loan_sdk_package/app/route/app_pages.dart';
import 'package:loan_sdk_package/app/themes/app_colors.dart';
import 'package:loan_sdk_package/utils/storage/storage_utils.dart';
import 'config/env.dart';
import 'data/models/dto/user_model.dart';

class App extends StatefulWidget {
  const App({super.key, required this.sdkRequest});

  final SdkRequest sdkRequest;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    Storage.setSdkUser(
      SdkUserModel(
        phoneNumber: widget.sdkRequest.username,
        clientId: widget.sdkRequest.clientId,
        clientSecret: widget.sdkRequest.clientSecret,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppBloc>().add(
            OnFetchUserProfile(sdkRequest: widget.sdkRequest),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state.userProfileFetched ?? false) {
          AppPages.router.goNamed(
            Routes.sdkCreditOnboarding,
            extra: {
              "profileId": state.userProfileResponse?.payload?.userId ?? "",
              "accessToken":
                  state.userProfileResponse?.payload?.token?.accessToken ?? "",
              "prevPageId": "",
            },
          );
          context.read<AppBloc>().add(OnResetUserProfile());
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: (state.isLoading ?? false)
              ? Center(child: const CircularProgressIndicator())
              : GestureDetector(
                  onTap: () {
                    if (FocusManager.instance.primaryFocus?.hasFocus ?? false) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                  },
                  child: SafeArea(
                    top: false,
                    bottom: true,
                    minimum: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom,
                    ),
                    child: MaterialApp.router(
                      builder: (context, child) {
                        return MediaQuery(
                          data: MediaQuery.of(
                            context,
                          ).copyWith(textScaler: TextScaler.noScaling),
                          child: child!,
                        );
                      },
                      title: 'Loan sdk',
                      debugShowCheckedModeBanner: false,
                      theme: ThemeData(
                        colorScheme: ColorScheme.fromSeed(
                          seedColor: AppColors.primaryColor(),
                        ),
                        scaffoldBackgroundColor: AppColors.backgroundColor,
                        bottomSheetTheme: BottomSheetThemeData(
                          backgroundColor: AppColors.backgroundColor,
                        ),
                        useMaterial3: true,
                        fontFamily: Env.fontFamily,
                      ),
                      routerConfig: AppPages.router,
                    ),
                  ),
                ),
        );
      },
    );
  }
}
