import 'package:app_pharmacy/core/get_it/di_instance.dart';
import 'package:app_pharmacy/core/route/custom_page_route_builder.dart';
import 'package:app_pharmacy/first_page.dart';
import 'package:app_pharmacy/login/bloc/authentication_bloc.dart';
import 'package:app_pharmacy/login/login_successful_screen.dart';
import 'package:app_pharmacy/login/sign_up_successful_screen.dart';
import 'package:app_pharmacy/login/singup_pharmacy.dart';
import 'package:app_pharmacy/login/term_and_condition/consent_screen.dart';
import 'package:app_pharmacy/login/term_and_condition/term_and_condition_screen.dart';
import 'package:app_pharmacy/menu/home_screen.dart';
import 'package:app_pharmacy/profile/bloc/profile_bloc.dart';
import 'package:app_pharmacy/profile/page/change_password_screen.dart';
import 'package:app_pharmacy/profile/page/qr_code_screen.dart';
import 'package:app_pharmacy/profile/profile_page.dart';
import 'package:app_pharmacy/profile/setting_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static const initialRouterName = FirstPage.routeName;

  static Route<dynamic>? router(RouteSettings settings) {
    switch (settings.name) {
      case FirstPage.routeName:
        return CustomPageRouteBuilder.route(
          name: FirstPage.routeName,
          builder: (ctx) => const FirstPage(),
          transitionType: RouteTransition.fade,
        );

      case LoginSuccessfulScreen.routeName:
        assert(
          settings.arguments is HomeScreenArgs || settings.arguments == null,
          'arguments must be HomeScreenArgs or null',
        );

        final args = settings.arguments as HomeScreenArgs;

        return CustomPageRouteBuilder.route(
          name: LoginSuccessfulScreen.routeName,
          builder: (ctx) => LoginSuccessfulScreen(
            args: args,
          ),
          transitionType: RouteTransition.fade,
        );

      case TermAndConditionScreen.routeName:
        return CustomPageRouteBuilder.route(
          name: TermAndConditionScreen.routeName,
          builder: (ctx) => const TermAndConditionScreen(),
          transitionType: RouteTransition.fade,
        );

      case ConsentScreen.routeName:
        return CustomPageRouteBuilder.route(
          name: ConsentScreen.routeName,
          builder: (ctx) => const ConsentScreen(),
          transitionType: RouteTransition.fade,
        );

      case singupmixpharmacy.routeName:
        return CustomPageRouteBuilder.route(
          name: singupmixpharmacy.routeName,
          builder: (ctx) => BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) => getIt<AuthenticationBloc>(),
            child: const singupmixpharmacy(),
          ),
          transitionType: RouteTransition.fade,
        );

      case singupmix2.routeName:
        return CustomPageRouteBuilder.route(
          name: singupmix2.routeName,
          builder: (ctx) => BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) => getIt<AuthenticationBloc>(),
            child: const singupmix2(),
          ),
          transitionType: RouteTransition.fade,
        );

      case singupmix3.routeName:
        return CustomPageRouteBuilder.route(
          name: singupmix3.routeName,
          builder: (ctx) => BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) => getIt<AuthenticationBloc>(),
            child: const singupmix3(),
          ),
          transitionType: RouteTransition.fade,
        );

      case QRCodeScreen.routeName:
        assert(
          settings.arguments is ProfileArgs || settings.arguments == null,
          'arguments must be ProfileArgs or null',
        );

        final args = settings.arguments as ProfileArgs;

        return CustomPageRouteBuilder.route(
          name: QRCodeScreen.routeName,
          builder: (ctx) => BlocProvider<ProfileBloc>(
            create: (BuildContext context) => getIt<ProfileBloc>(),
            child: QRCodeScreen(
              args: args,
            ),
          ),
          transitionType: RouteTransition.fade,
        );

      case HomeScreen.routeName:
        assert(
          settings.arguments is HomeScreenArgs || settings.arguments == null,
          'arguments must be HomeScreenArgs or null',
        );

        final args = settings.arguments as HomeScreenArgs;

        return CustomPageRouteBuilder.route(
          name: HomeScreen.routeName,
          builder: (ctx) => MultiBlocProvider(
            providers: [
              BlocProvider<ProfileBloc>(
                create: (BuildContext context) => getIt<ProfileBloc>(),
              ),
            ],
            child: HomeScreen(args: args),
          ),
          transitionType: RouteTransition.fade,
        );

      case SignUpSuccessfulScreen.routeName:
        return CustomPageRouteBuilder.route(
          name: SignUpSuccessfulScreen.routeName,
          builder: (ctx) => SignUpSuccessfulScreen(),
          transitionType: RouteTransition.fade,
        );

      case ChangePasswordScreen.routeName:
        assert(
          settings.arguments is ProfileArgs || settings.arguments == null,
          'arguments must be ProfileArgs or null',
        );

        final args = settings.arguments as ProfileArgs;

        return CustomPageRouteBuilder.route(
          name: ChangePasswordScreen.routeName,
          builder: (ctx) => BlocProvider<ProfileBloc>(
            create: (BuildContext context) => getIt<ProfileBloc>(),
            child: ChangePasswordScreen(
              args: args,
            ),
          ),
          transitionType: RouteTransition.fade,
        );

      case settingprofile.routeName:
        assert(
          settings.arguments is ProfileArgs || settings.arguments == null,
          'arguments must be ProfileArgs or null',
        );

        final args = settings.arguments as ProfileArgs;

        return CustomPageRouteBuilder.route(
          name: settingprofile.routeName,
          builder: (ctx) => BlocProvider<ProfileBloc>(
            create: (BuildContext context) => getIt<ProfileBloc>(),
            child: settingprofile(
              args: args,
            ),
          ),
          transitionType: RouteTransition.fade,
        );
      default:
        assert(false, 'this should not be reached');
        return null;
    }
  }
}
