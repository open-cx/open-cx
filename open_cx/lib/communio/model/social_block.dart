import 'package:open_cx/communio/view/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialBlock {

  static final Map<String, SvgPicture> _socialLogo = {
    'facebook':SvgPicture.asset(
      'open_cx/communio/assets/facebook.svg',
      color: navyBlueColor,
    ),
    'instagram':SvgPicture.asset(
      'open_cx/communio/assets/instagram.svg',
      color: navyBlueColor,
    ),
    'twitter':SvgPicture.asset(
      'open_cx/communio/assets/twitter.svg',
      color: navyBlueColor,
    ),
    'github':SvgPicture.asset(
      'open_cx/communio/assets/github.svg',
      color: navyBlueColor,
    ),
    'linkedin':SvgPicture.asset(
      'open_cx/communio/assets/linkedin.svg',
      color: navyBlueColor,
    ),
    'default':SvgPicture.asset(
      'open_cx/communio/assets/default_social.svg',
      color: navyBlueColor,
    )
  };

  String name;
  String url;
  SvgPicture logo;

  SocialBlock(this.name, this.url) {
    if (_socialLogo.containsKey(name)) {
      this.logo = _socialLogo[name];
    }
    else {
      this.logo = _socialLogo['default'];
    }
  }

  @override
  String toString() {
    return '\n\t SocialBlock{name: $name, url: $url}';
  }

}
