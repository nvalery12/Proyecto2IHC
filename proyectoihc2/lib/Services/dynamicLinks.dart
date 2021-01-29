import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';

class DynamicLinksService {

  void fetchLinkData() async {
    // FirebaseDynamicLinks.getInitialLInk does a call to firebase to get us the real link because we have shortened it.
    var link = await FirebaseDynamicLinks.instance.getInitialLink();

    // This link may exist if the app was opened fresh so we'll want to handle it the same way onLink will.
    handleLinkData(link);

    // This will handle incoming links if the application is already opened
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
          handleLinkData(dynamicLink);
        });
  }

  void handleLinkData(PendingDynamicLinkData data) {
    final Uri uri = data?.link;
    if (uri != null) {
      final queryParams = uri.queryParameters;
      if (queryParams.length > 0) {
        String userName = queryParams["username"];
        // verify the username is parsed correctly
        print("My users username is: $userName");
      }
    }
  }

  Future<Uri> createDynamicLink({@required String groupUID}) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      // This should match firebase but without the username query param
      uriPrefix: 'https://proyectoihc2.page.link',
      // This can be whatever you want for the uri, https://yourapp.com/groupinvite?username=$userName
      link: Uri.parse('https://proyectoihc2.page.link/groupinvite?username=$groupUID'),
      androidParameters: AndroidParameters(
        packageName: 'com.example.proyectoihc2',
        minimumVersion: 1,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.test.demo',
        minimumVersion: '1',
        appStoreId: '',
      ),
    );
    final Uri link = await parameters.link;
    final ShortDynamicLink shortenedLink = await DynamicLinkParameters.shortenUrl(link, DynamicLinkParametersOptions(
          shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable),
    );
    final Uri shortUrl = shortenedLink.shortUrl;
    print(shortUrl.toString());
    return shortUrl;
  }
}