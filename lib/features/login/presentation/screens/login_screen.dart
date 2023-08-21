import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:malf_application/config/routes/app_route.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

part 'login_screen.g.dart';

const baseUrl = 'http://3.36.185.179:8000/';

final logger = Logger();

@riverpod
FutureOr<Map<String, String>> fetchLogin(Ref ref) async {
  final dio = Dio(BaseOptions(
    baseUrl: '${baseUrl}auth/kakao',
    //headers: {'Authorization': 'test_1'},
  ));
  dio.options.followRedirects = true;
  dio.options.responseType = ResponseType.plain;

  Response response = await dio.get("");

  Uri rrrr = response.realUri;

  logger.d(rrrr);

  // kakaoSchemeStream.listen((rrrr) {
  //   logger.d('kakaoSchemeStream : $rrrr');
  // });

  Map<String, String> result = {'refreshToken': '', 'accessToken': ''};

  if (await isKakaoTalkInstalled()) {
    try {
      await UserApi.instance.loginWithKakaoTalk();
      logger.d('카카오톡으로 로그인 성공');
    } catch (error) {
      logger.d('카카오톡으로 로그인 실패 $error');

      // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
      try {
        await UserApi.instance.loginWithKakaoAccount();
        logger.d('카카오계정으로 로그인 성공asdasdasd');
      } catch (error) {
        logger.e("$error");
        logger.e('카카오계정으로 로그인 실dddd패 $error');
      }
    }
  } else {
    try {
      await UserApi.instance.loginWithKakaoAccount();
      var usertoken = await UserApi.instance.accessTokenInfo();
      logger.d("카카오계정으로 로그인 성공 ${usertoken.toJson()}}");
    } catch (error) {
      logger.e('카카오계정으로 로그인 실패 $error');
    }
  }
  return result;

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
    final fetchLoginAsyncValue = ref.watch(fetchLoginProvider);
    return Scaffold(
      body: fetchLoginAsyncValue.when(
        data: (data) {
          return const TestLoginBody();
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        error: (error, stackTrace) {
          return const Center(
            child: Text('error'),
          );
        },
      ),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('refresh : ${fetchLoginAsyncValue.value!['refreshToken']}'),
        Text('access : ${fetchLoginAsyncValue.value!['accessToken']}'),
        FloatingActionButton(onPressed: () {
          context.router.push(HomeRoute());
        })
      ],
    );
  }
}
