import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:malf_application/config/routes/app_route.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'login_screen.g.dart';

const baseUrl = 'http://13.125.43.68:8000/';

final logger = Logger();

String accessToken = '';
String refreshToken = '';

final PlatformWebViewControllerCreationParams params =
    (WebViewPlatform.instance is WebKitWebViewPlatform)
        ? WebKitWebViewControllerCreationParams(
            allowsInlineMediaPlayback: true,
            mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
          )
        : const PlatformWebViewControllerCreationParams();

final WebViewController controller =
    WebViewController.fromPlatformCreationParams(params);

@riverpod
FutureOr<Uri> fetchLogin(Ref ref) async {
  final dio = Dio(BaseOptions(
    baseUrl: '${baseUrl}auth/kakao',
    //headers: {'Authorization': 'test_1'},
  ));
  dio.options.followRedirects = true;
  dio.options.responseType = ResponseType.plain;

  Response response = await dio.get("");

  Uri rrrr = response.realUri;
  //Uri rrrr = Uri.parse('https://accounts.kakao.com/login/?continue=https%3A%2F%2Fkauth.kakao.com%2Foauth%2Fauthorize%3Fresponse_type%3Dcode%26redirect_uri%3Dhttp%253A%252F%252F3.36.185.179%253A8000%252Fauth%252Fkakao%252Fcallback%26through_account%3Dtrue%26client_id%3D02004f12cbb6023c0878057134e2bdb7#login')
  logger.d(rrrr);

  // kakaoSchemeStream.listen((rrrr) {
  //   logger.d('kakaoSchemeStream : $rrrr');
  // });

  return rrrr;

  // if (await isKakaoTalkInstalled()) {
  //   try {
  //     await AuthCodeClient.instance.authorizeWithTalk(
  //       redirectUri: '$rrrr',
  //     );
  //     logger.d('카카오톡으로 로그인 성공');
  //   } catch (error) {
  //     logger.d('카카오톡으로 로그인 실패 $error');

  //     // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
  //     try {
  //       await AuthCodeClient.instance.authorize(
  //         redirectUri: '$rrrr',
  //       );
  //       logger.d('카카오계정으로 로그인 성공asdasdasd');
  //     } catch (error) {
  //       logger.e("$error");
  //       logger.e('카카오계정으로 로그인 실dddd패 $error');
  //     }
  //   }
  // } else {
  //   try {
  //     await AuthCodeClient.instance.authorize(
  //       redirectUri: '$rrrr}',
  //     );
  //     var usertoken = await UserApi.instance.accessTokenInfo();
  //     logger.d("카카오계정으로 로그인 성공 ${usertoken.toJson()}}");
  //   } catch (error) {
  //     logger.e('카카오계정으로 로그인 실패 $error');
  //   }
  // }

  // try {
  //   final response = await dio.get("");
  //   if (response.statusCode == 200) {
  //     logger.i(response.data);
  //     result['refreshToken'] = response.data['refreshToken'];
  //     result['accessToken'] = response.data['accessToken'];
  //     return result;
  //   } else {
  //     return result;
  //   }
  // } catch (error) {
  //   logger.e(error);
  //   return result;
  // }
}

@RoutePage()
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    return const Scaffold(
      body: TestLoginBody(),
    );
  }
}

class TestLoginBody extends ConsumerStatefulWidget {
  const TestLoginBody({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TestLoginBodyState();
}

class _TestLoginBodyState extends ConsumerState<TestLoginBody> {
  @override
  Widget build(BuildContext context) {
    final fetchLoginAsyncValue = ref.watch(fetchLoginProvider);

    return fetchLoginAsyncValue.when(data: (data) {
      controller
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              debugPrint('WebView is loading (progress : $progress%)');
            },
            onPageStarted: (String url) {
              debugPrint('Page started loading: $url');
            },
            onPageFinished: (String url) {
              debugPrint('Page finished loading: $url');
            },
            onWebResourceError: (WebResourceError error) {
              debugPrint('''
              Page resource error:
                code: ${error.errorCode}
                description: ${error.description}
                errorType: ${error.errorType}
                isForMainFrame: ${error.isForMainFrame}
          ''');
            },
            onNavigationRequest: (NavigationRequest request) async {
              logger.i('allowing navigation to ${request.url}');
              if (request.url
                  .contains('http://13.125.43.68:8000/auth/kakao/callback')) {
                Response response = await Dio().get(request.url);
                accessToken = response.data['token']['accessToken'];
                refreshToken = response.data['token']['refreshToken'];
                logger.d('accessToken : $accessToken');
                logger.d('refreshToken : $refreshToken');
                //destroy WebView
                context.router.pushAndPopUntil(
                    HomeRoute(
                        accessToken: accessToken, refreshToken: refreshToken),
                    predicate: (route) => false);
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        // ..addJavaScriptChannel(
        //   'Toaster',
        //   onMessageReceived: (JavaScriptMessage message) {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       SnackBar(content: Text(message.message)),
        //     );
        //   },
        // )
        ..loadRequest(Uri.parse('${baseUrl}auth/kakao'));

      if (controller.platform is AndroidWebViewController) {
        AndroidWebViewController.enableDebugging(true);
        (controller.platform as AndroidWebViewController)
            .setMediaPlaybackRequiresUserGesture(false);
      }

      return SafeArea(
          bottom: false,
          child: SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width * 0.8,
              child: WebViewWidget(controller: controller)));
    }, error: (error, stackTrace) {
      return const Center(
        child: Text('error'),
      );
    }, loading: () {
      return const Center(
        child: Text('loading'),
      );
    });

    // final fetchLoginAsyncValue = ref.watch(fetchLoginProvider);
    // return fetchLoginAsyncValue.when(data:
    // (data) {
    //   return data;
    // }, error: (error, stackTrace) {
    //   return const Center(
    //     child: Text('error'),
    //   );
    // }, loading: () {
    //   return const Center(
    //     child: Text('loading'),
    //   );
    // });
  }
}
