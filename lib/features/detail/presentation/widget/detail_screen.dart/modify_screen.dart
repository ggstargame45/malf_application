import 'package:malf_application/features/detail/data/provider/detail_data_provider.dart';
import 'package:malf_application/features/write/presentation/providers/write_screen_providers.dart';

void settingWriteScreenProvider(int postId) {
  // provider 설정
  modifyProviderContainer.read(isModifyScreenProvider.notifier).state = true;

  final data = modifyProviderContainer
      .read(jsonDataProvider(postId))
      .value!
      .jsonData
      .data![0];
  // title, content, category, time, place, people
  List<String> detailList = [];
  detailList.add(data!.title.toString());
  detailList.add(data.content.toString());
  detailList.add(data.category.toString());
  detailList.add(data.meetingstarttime.toString());
  detailList.add(data.meetinglocation.toString());
  detailList.add(data.meetingcapacity.toString());
  modifyProviderContainer.read(detailScreenProvider.notifier).state =
      detailList;
}
