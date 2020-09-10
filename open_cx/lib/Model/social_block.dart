import 'package:communio/view/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialBlock {

  static final Map<String, SvgPicture> socialLogo = {
    'facebook':SvgPicture.asset(
      'assets/facebook.svg',
      color: navyBlueColor,
    ),
    'instagram':SvgPicture.asset(
      'assets/instagram.svg',
      color: navyBlueColor,
    ),
    'twitter':SvgPicture.asset(
      'assets/twitter.svg',
      color: navyBlueColor,
    ),
    'github':SvgPicture.asset(
      'assets/github.svg',
      color: navyBlueColor,
    ),
    'linkedin':SvgPicture.asset(
      'assets/linkedin.svg',
      color: navyBlueColor,
    ),
    'default':SvgPicture.asset(
      'assets/default_social.svg',
      color: navyBlueColor,
    )
  };

  String name;
  String url;
  SvgPicture logo;

  SocialBlock(this.name, this.url) {
    if (socialLogo.containsKey(name)) {
      this.logo = socialLogo[name];
    }
    else {
      this.logo = socialLogo['default'];
    }
  }

  @override
  String toString() {
    return '\n\t SocialBlock{name: $name, url: $url}';
  }

}
