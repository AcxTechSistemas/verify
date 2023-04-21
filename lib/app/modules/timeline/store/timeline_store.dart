import 'package:mobx/mobx.dart';

part 'timeline_store.g.dart';

class TimelineStore = TimelineStoreBase with _$TimelineStore;

abstract class TimelineStoreBase with Store {
  @observable
  DateTime selectedDate = DateTime.now();

  @observable
  int selectedAccount = 0;

  @computed
  bool get showTodayFab {
    final now = DateTime.now();
    final currentDate = DateTime(
      now.year,
      now.month,
      now.day,
    );
    final currentSelectedDate = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );
    return currentDate != currentSelectedDate;
  }

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
