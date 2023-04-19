import 'package:mobx/mobx.dart';

part 'timeline_store.g.dart';

class TimelineStore = TimelineStoreBase with _$TimelineStore;

abstract class TimelineStoreBase with Store {
  @observable
  int selectedAccount = 0;

  @computed
  bool get selectedSicoob => selectedAccount == 0;

  @computed
  bool get selectedBB => selectedAccount == 1;

  @action
  setselectedAccount(int selected) {
    selectedAccount = selected;
  }
}
