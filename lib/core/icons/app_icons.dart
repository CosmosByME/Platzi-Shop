import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  static SvgPicture search = SvgPicture.asset("assets/icons/search.svg");
  static SvgPicture heart = SvgPicture.asset("assets/icons/heart.svg");
  static SvgPicture heartFill = SvgPicture.asset("assets/icons/heart_fill.svg");
  static SvgPicture startFill = SvgPicture.asset(
    "assets/icons/star_filled.svg",
  );
  static SvgPicture minus = SvgPicture.asset("assets/icons/minus.svg");
  static SvgPicture plus = SvgPicture.asset("assets/icons/plus.svg");

  //Navigation Bar

  static SvgPicture homeSelected = SvgPicture.asset(
    "assets/icons/home_selected.svg",
  );
  static SvgPicture logo = SvgPicture.asset(
    "assets/icons/logo.svg",
  );
  static SvgPicture homeUnselected = SvgPicture.asset(
    "assets/icons/home_unselected.svg",
  );

  static SvgPicture catalogSelected = SvgPicture.asset(
    "assets/icons/catalog_selected.svg",
  );
  static SvgPicture catalogUnselected = SvgPicture.asset(
    "assets/icons/catalog_unselected.svg",
  );

  static SvgPicture cartSelected = SvgPicture.asset(
    "assets/icons/cart_selected.svg",
  );
  static SvgPicture cartUnselected = SvgPicture.asset(
    "assets/icons/cart_unselected.svg",
  );

  static SvgPicture favoriteSelected = SvgPicture.asset(
    "assets/icons/favorite_selected.svg",
  );
  static SvgPicture favoriteUnselected = SvgPicture.asset(
    "assets/icons/favorite_unselected.svg",
  );

  static SvgPicture profileSelected = SvgPicture.asset(
    "assets/icons/profile_selected.svg",
  );
  static SvgPicture profileUnselected = SvgPicture.asset(
    "assets/icons/profile_unselected.svg",
  );
}

extension ExtSvg on SvgPicture {
  SvgPicture copyWith({Color? color, double? width, double? height}) {
    return SvgPicture(
      bytesLoader,
      height: height ?? this.height,
      width: width ?? this.width,
      colorFilter: color != null
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : colorFilter,
    );
  }
}
