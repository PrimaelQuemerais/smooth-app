import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_app/generic_lib/bottom_sheets/smooth_bottom_sheet.dart';
import 'package:smooth_app/generic_lib/buttons/smooth_simple_button.dart';
import 'package:smooth_app/generic_lib/design_constants.dart';
import 'package:smooth_app/pages/user_management/login_page.dart';
import 'package:smooth_app/pages/user_management/sign_up_page.dart';
import 'package:smooth_app/themes/smooth_theme.dart';
import 'package:smooth_app/themes/smooth_theme_colors.dart';

class AuthenticationBottomSheet {
  AuthenticationBottomSheet(this.context);

  final BuildContext context;

  void show() {
    showSmoothModalSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        final AppLocalizations appLocalizations = AppLocalizations.of(context);
        final SmoothColorsThemeExtension extension =
            context.extension<SmoothColorsThemeExtension>();
        final ThemeData theme = Theme.of(context);

        return Stack(
          alignment: AlignmentDirectional.topCenter,
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              top: -68.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                padding: const EdgeInsetsDirectional.all(SMALL_SPACE),
                decoration: BoxDecoration(
                  color: extension.primaryBlack,
                  borderRadius: const BorderRadius.only(
                    topLeft: ROUNDED_RADIUS,
                    topRight: ROUNDED_RADIUS,
                  ),
                ),
                child: Transform.translate(
                  offset: const Offset(-24.0, 2.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SvgPicture.asset(
                        'assets/onboarding/authentication.svg',
                        width: 100.0,
                      ),
                      Text(
                        appLocalizations.authentication_bottom_sheet_header,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsetsDirectional.all(LARGE_SPACE),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: ROUNDED_RADIUS,
                  topRight: ROUNDED_RADIUS,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          appLocalizations.authentication_bottom_sheet_title,
                        ),
                      ),
                      const SizedBox(
                        width: MEDIUM_SPACE,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 28.0,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: extension.primaryBlack,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: LARGE_SPACE,
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          appLocalizations
                              .authentication_bottom_sheet_title_addition,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: LARGE_SPACE * 2,
                  ),
                  chip(appLocalizations.authentication_bottom_sheet_first_chip),
                  const SizedBox(
                    height: LARGE_SPACE,
                  ),
                  chip(
                      appLocalizations.authentication_bottom_sheet_second_chip),
                  const SizedBox(
                    height: LARGE_SPACE,
                  ),
                  chip(appLocalizations.authentication_bottom_sheet_third_chip),
                  const SizedBox(
                    height: LARGE_SPACE * 2,
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          appLocalizations.authentication_bottom_sheet_subtitle,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: LARGE_SPACE * 2,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SmoothSimpleButton(
                        buttonColor: extension.primaryMedium,
                        child: Text(
                          appLocalizations.login,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: extension.primaryBlack,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(
                            context,
                            rootNavigator: true,
                          ).push<dynamic>(
                            MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) =>
                                  const LoginPage(),
                            ),
                          );
                        },
                      ),
                      SmoothSimpleButton(
                        padding: const EdgeInsetsDirectional.symmetric(
                          vertical: BALANCED_SPACE,
                        ),
                        buttonColor: extension.primaryBlack,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              appLocalizations.create_account,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                            const SizedBox(
                              width: LARGE_SPACE,
                            ),
                            Container(
                              padding: const EdgeInsetsDirectional.all(
                                2.0,
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_forward_outlined,
                                size: 24.0,
                                color: extension.primaryBlack,
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.of(
                            context,
                            rootNavigator: true,
                          ).push<dynamic>(
                            MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) =>
                                  const SignUpPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget chip(String text) {
    return Transform.rotate(
      angle: -0.05,
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: SMALL_SPACE,
          horizontal: LARGE_SPACE,
        ),
        decoration: BoxDecoration(
          color: context.extension<SmoothColorsThemeExtension>().success,
          borderRadius: ROUNDED_BORDER_RADIUS,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
