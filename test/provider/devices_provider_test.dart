import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yonomi_flutter_demo/providers/devices_provider.dart';
import 'package:yonomi_platform_sdk/third_party/yonomi_graphql_schema/schema.docs.schema.gql.dart';
import 'package:yonomi_platform_sdk/yonomi-sdk.dart';

import 'devices_provider_test.mocks.dart';

class GetDevicesFunction extends Mock {
  Future<List<Device>> call(Request request);
}

class GetDeviceDetailsFunction extends Mock {
  Future<Device> call(Request request, String id);
}

class SendLockUnlockFunction extends Mock {
  Future<void> call(Request request, String id, bool lockUnlock);
}

@GenerateMocks(
    [GetDevicesFunction, GetDeviceDetailsFunction, SendLockUnlockFunction])
void main() {
  final Device defaultLock = Device(
    "someId",
    "someDisplayName",
    "someDescription",
    "someManufacturerName",
    "someModel",
    "someSerialNumber",
    GDateTime('value'),
    GDateTime('value'),
    [
      LockTrait({IsLocked(true)}, {SupportsIsJammed(false)})
    ],
  );
  test(
      'hydrateDevices fetchs and returns properly-built list of DeviceModel objects from Repository',
      () async {
    Request request = Request("", {});
    MockGetDevicesFunction mockGetDevicesFunction = MockGetDevicesFunction();
    when(mockGetDevicesFunction(request))
        .thenAnswer((_) => Future.value([defaultLock]));
    DevicesProvider devicesProvider = DevicesProvider(request,
        injectGetDevicesMethod: mockGetDevicesFunction);

    await devicesProvider.hydrateDevices(
        injectGetDevicesMethod: mockGetDevicesFunction);

    expect(devicesProvider.devices, isNotEmpty);
    expect(devicesProvider.devices[0].id, equals("someId"));
    expect(devicesProvider.devices[0].displayName, equals("someDisplayName"));
    expect(devicesProvider.devices[0].description, equals("someDescription"));
    expect(devicesProvider.devices[0].traits, isNotEmpty);
    expect(devicesProvider.devices[0].traits.first, isA<LockTrait>());
  });

  test(
      'performAction calls LockRepository method to initiate lock / unlock action',
      () async {
    String deviceId = "someDeviceId";
    Request request = Request("", {});

    MockGetDeviceDetailsFunction mockGetDeviceDetailsFunction =
        MockGetDeviceDetailsFunction();
    when(mockGetDeviceDetailsFunction(request, deviceId))
        .thenAnswer((_) => Future.value(defaultLock));

    MockGetDevicesFunction mockGetDevicesFunction = MockGetDevicesFunction();
    when(mockGetDevicesFunction(request))
        .thenAnswer((_) => Future.value([defaultLock]));

    MockSendLockUnlockFunction mockSendLockUnlockFunction =
        MockSendLockUnlockFunction();

    DevicesProvider devicesProvider = DevicesProvider(request,
        injectGetDevicesMethod: mockGetDevicesFunction);

    await devicesProvider.performAction(
      LockTrait({IsLocked(true)}, {SupportsIsJammed(false)}),
      deviceId,
      injectGetDeviceDetailsMethod: mockGetDeviceDetailsFunction,
      injectSendLockUnlockMethod: mockSendLockUnlockFunction,
    );

    verify(mockSendLockUnlockFunction(request, deviceId, false)).called(1);
  });
}
