import 'enumeration.dart';

class AssetManager extends Enum<String> {

  AssetManager(String value) : super(value);

  static  AssetManager earth = AssetManager('assets/images/earth.png');
  static  AssetManager google = AssetManager('assets/images/Google.png');
  static  AssetManager facebook = AssetManager('assets/images/Facebook.png');
  static  AssetManager twitter = AssetManager('assets/images/Twitter.png');

}
