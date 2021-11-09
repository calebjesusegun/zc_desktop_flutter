import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:zc_desktop_flutter/model/app_models.dart';
import 'package:zc_desktop_flutter/services/auth_service.dart';

import '../helpers/test_helpers.dart';

void main() {
  setUp(() => registerServices());
  tearDown(() => unregisterServices());
  group('runLogic -', () {
    test('set New Room Info test', () {
      final service = getAndRegisterDMService();
      service.setNewRoomInfo(Users(firstName: 'Zuri User'));
      expect(
          service.getExistingRoomInfo!.otherUserProfile.firstName, 'Zuri User');
    });
    test('get user', () {
      final service = getAndRegisterDMService();
      service.getUser();
    });
    test('get current logged in user', () {
      final service = getAndRegisterDMService();
      expect(
          service.getCurrentLoggedInUser(),
          User(
              id: '1',
              firstName: 'Dedan',
              lastName: 'Ndungu',
              displayName: 'dedankibere',
              email: 'dnkibere@gmail.com',
              phone: '254700314700',
              status: 0,
              timeZone: 'timeZone',
              createdAt: 'createdAt',
              updatedAt: 'updatedAt',
              token: 'token'));
    });
    test('get Existing Room Info', () {
      final service = getAndRegisterDMService();
          
      expect(
          service.getExistingRoomInfo,
          DM(
              roomInfo: DMRoomsResponse(),
              currentUserProfile: UserProfile(),
              otherUserProfile: UserProfile()));
    });

    test('send message function', () {
      final service = getAndRegisterDMService();
      service.sendMessage('12345', '98765', 'Hello, are u still working');
    });
  });
}
