import 'dart:convert';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:zc_desktop_flutter/app/app.locator.dart';
import 'package:zc_desktop_flutter/app/app.router.dart';
import 'package:zc_desktop_flutter/constants/app_strings.dart';
import 'package:zc_desktop_flutter/core/enums/button_type_enum.dart';
import 'package:zc_desktop_flutter/model/app_models.dart';
import 'package:zc_desktop_flutter/services/channels_service.dart';
import 'package:zc_desktop_flutter/services/dm_service.dart';
import 'package:zc_desktop_flutter/services/files_service.dart';
import 'package:zc_desktop_flutter/services/local_storage_service.dart';
import 'package:zc_desktop_flutter/services/organization_service.dart';
import 'package:zc_desktop_flutter/ui/shared/smart_widgets/search_modal/users_local_data.dart';

class SearchViewModel extends BaseViewModel {
  static const savedSearchKey = 'savedSearches';
  final _navigationService = locator<NavigationService>();
  final _dmService = locator<DMService>();
  final _organizationService = locator<OrganizationService>();
  final _channelsService = locator<ChannelsService>();
  final _localStorageService = locator<LocalStorageService>();
  final _filesService = locator<FilesService>();

  String? _text;
  String? _hintText;
  String? _textFieldText;
  int userDataLength = 0;
  int availableListLength = 0;
  bool isClicked = false;
  bool swap = false;
  bool textFieldActivated = false;
  ButtonType buttonType = ButtonType.CHANNELS;
  late List<DummyUser> users;
  final userData = usersData;

  String searchQuery = '';

  String get text => _text!;
  String get hintText => _hintText!;
  String get textFieldText => _textFieldText!;
  List<dynamic> _searchList = [];
  List<dynamic> get searchList => [..._searchList];
  List<DummyUser> _userNames = [];
  List<DummyUser> get userDatas => [..._userNames];
  String? selectedTerm;

  int _historyLength = 0;
  int get historyLenth => _historyLength;

  List _searchHistory = [];
  List get searchHistory => _searchHistory;

  void saveSearch() {
    _searchHistory.add(searchQuery);

    _localStorageService.saveToDisk(
        savedSearchKey, json.encode(_searchHistory));
    //notifyListeners();
  }

  void fetchAndSetSearchHistory() async {
    final search = _localStorageService.getFromDisk(savedSearchKey);
    _searchHistory = json.decode(search.toString()) ?? ['No recent search'];
    _historyLength = _searchHistory.length > 4 ? 4 : _searchHistory.length;
    // get channels using the current organization id and store the list in _searchList
    _searchList = await _channelsService.getChannels(
        organizationId: _organizationService.getOrganizationId());
  }

  toggleButtonClicked() {
    isClicked = !isClicked;
    notifyListeners();
  }

  toggleTextFieldActivated() {
    textFieldActivated = !textFieldActivated;
    notifyListeners();
  }

  toggleSwap() {
    swap = !swap;
    notifyListeners();
  }

  getTextAndHintText() {
    switch (buttonType) {
      case ButtonType.CHANNELS:
        {
          _text = ButtonText4;
          _hintText = SearchModal;
        }
        break;
      case ButtonType.MESSAGE:
        {
          _text = ButtonText;
          _hintText = SearchModal1;
          availableListLength = userData.length;
        }
        break;
      case ButtonType.FILE:
        {
          _text = ButtonText2;
          _hintText = SearchModal2;
        }
        break;
      case ButtonType.PEOPLE:
        {
          _text = ButtonText3;
          _hintText = SearchModal3;
        }
        break;
      default:
        {}
        break;
    }
  }

  popDialog() {
    _navigationService.popRepeated(0);
  }

  void getSuggestionsForDM(String query) async {
    var userList = List.of(_searchList).where((e) {
      final userLower = e.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return userLower.startsWith(queryLower);
    }).toList();

    availableListLength = userList.length;
    _searchList = userList;
    notifyListeners();
  }

  void onChange(String value) {
    textFieldActivated = true;
    switch (buttonType) {
      case ButtonType.CHANNELS:
        {
          getSuggestionsForChannels(value);
        }
        break;
      case ButtonType.PEOPLE:
        {
          getSuggestionsForDM(value);
        }
        break;
      case ButtonType.FILE:
        {
          getSuggestionsForFiles(value);
        }
        break;

      default:
    }
    notifyListeners();
  }

  void getSuggestionsForChannels(String query) async {
    var filteredList = List.of(_searchList).where((e) {
      final channelNameToLower = e.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return channelNameToLower.startsWith(queryLower);
    }).toList();

    availableListLength = filteredList.length;
    _searchList = filteredList;
    notifyListeners();
  }

  void getSuggestionsForFiles(String query) async {
    final response = await _filesService.fetchFileListUsingOrgId();
    _searchList.addAll(response.channelfiles);
    _searchList.addAll(response.threadfiles);
    var filteredList = List.of(_searchList).where((e) {
      final channelNameToLower = e.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return channelNameToLower.startsWith(queryLower);
    }).toList();

    availableListLength = filteredList.length;
    _searchList = filteredList;
    notifyListeners();
  }

  void goToChannelsView() {
    _navigationService.navigateTo(OrganizationViewRoutes.channelsView, id: 1);
  }

  void searchNavigate(dynamic data) {
    switch (buttonType) {
      case ButtonType.CHANNELS:
        {
          searchChannels(data as Channel);
        }
        break;
      case ButtonType.PEOPLE:
        {
          searchUser(data as Users);
        }
        break;

      default:
    }
  }

  void searchChannels(Channel channel) {
    _navigationService.navigateTo(OrganizationViewRoutes.channelsView);
  }

  void searchUser(Users user) {
    _dmService.setUser(user);
    _navigationService.navigateTo(OrganizationViewRoutes.dmView);
  }
}