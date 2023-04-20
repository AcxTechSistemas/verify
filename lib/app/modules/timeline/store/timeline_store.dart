import 'package:mobx/mobx.dart';

part 'timeline_store.g.dart';

class TimelineStore = TimelineStoreBase with _$TimelineStore;

abstract class TimelineStoreBase with Store {
  final currentDate = DateTime.now();

  @observable
  DateTime selectedDate = DateTime.now();

  @observable
  int selectedAccount = 0;

  @computed
  bool get showTodayFab => selectedDate.day != currentDate.day;

  @computed
  bool get selectedSicoob => selectedAccount == 0;

  @computed
  bool get selectedBB => selectedAccount == 1;

  @action
  void setSelectedDate(DateTime date) {
    selectedDate = date;
  }

  @action
  setselectedAccount(int selected) {
    selectedAccount = selected;
  }
}
