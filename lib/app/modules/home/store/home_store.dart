import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  @observable
  int selectedAccountCard = 0;

  @computed
  bool get firstAccountSelected => selectedAccountCard == 0;

  @computed
  bool get secondAccountSelected => selectedAccountCard == 1;

  @action
  setSelectedAccountCard(int selectedCard) {
    selectedAccountCard = selectedCard;
  }
}
