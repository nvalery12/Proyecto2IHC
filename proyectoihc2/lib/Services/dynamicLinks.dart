import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';

class DynamicLinksService {

  void fetchLinkData() async {
    // FirebaseDynamicLinks.getInitialLInk does a call to firebase to get us the real link because we have shortened it.
    var link = await FirebaseDynamicLinks.instance.getInitialLink();
    print("!!!!");
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
      uriPrefix: 'https://proyectoihc2.page.link',
      link: Uri.parse('https://proyectoihc2.page.link/$groupUID'),
      androidParameters: AndroidParameters(
        packageName: 'com.example.proyectoihc2',
        minimumVersion: 0,
      ),
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,

      ),

    );

    final url = await parameters.buildUrl();
    //final url2 = await parameters.buildShortLink();
    print(url.toString());
    //print(url2.shortUrl.toString());
  }

}