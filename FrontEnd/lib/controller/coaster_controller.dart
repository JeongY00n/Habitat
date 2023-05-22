import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class CoasterController extends GetxController {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  // 연결상태 저장용
  BluetoothDeviceState deviceState = BluetoothDeviceState.disconnected;

  RxString coasterStatus = '연결 대기중'.obs;
  RxString coasterData = '데이터 아무것도 없다'.obs;
  RxString connectDeviceState = "disconnect".obs;
  // disconnect, standby, connect
  RxBool connectDataState = false.obs;

  int time = 0;
  String type = '';
  RxInt water = 0.obs;
  int cnt = 0;

  late BluetoothDevice device;

  void scanDevice() async {
    // 스캔 결과 초기화
    cnt = 0;
    coasterStatus.value = '연결 중...';
    // 연결상태 : 대기
    connectDeviceState.value = "standby";
    //스캔 시작 제한시간 5초
    await flutterBlue.startScan(timeout: const Duration(seconds: 5));
    // 스캔 결과 할당
    flutterBlue.scanResults.listen(
      (results) async {
        for (var element in results) {
          debugPrint("률루가 들어왔을까??? ${element.device.name}");
          if (element.device.name == '랼랴랴') {
            coasterStatus.value = '률류 연결!!!';
            device = element.device;
            connectDeviceState.value = "connect";
            await connectDevice();
            return;
          }
        }
        coasterStatus.value = '블루투스를 찾을 수 없습니다.';
      },
    );
    connectDeviceState.value = "disconnect";
  }

  connectDevice() async {
    bool returnValue = true;

    await device.connect(autoConnect: false).timeout(
      const Duration(milliseconds: 10000),
      onTimeout: () {
        returnValue = false;
        debugPrint("연결 실패 ㅠ.ㅠ");
      },
    ).then((data) async {
      if (returnValue) {
        List<BluetoothService> bleService = await device.discoverServices();
        Map<String, String> notifyDatas = {};
        debugPrint("연결완료");
        for (BluetoothService service in bleService) {
          for (BluetoothCharacteristic c in service.characteristics) {
            await device.requestMtu(223);

            if (!c.isNotifying) {
              try {
                await c.setNotifyValue(true);
                // 받을 데이터 변수 Map 형식으로 키 생성
                notifyDatas[c.uuid.toString()] = '';

                // 데이터 읽기 처리!
                c.value.listen((value) async {
                  debugPrint('받은 데이터 : ${c.uuid} : $value');

                  // 받은 데이터 저장 화면 표시용
                  notifyDatas[c.uuid.toString()] = ascii.decode(value);
                  debugPrint('데이터 아스키 변환 : ${notifyDatas[c.uuid.toString()]}');

                  // notify key가 있다면
                  if (notifyDatas.containsKey(c.uuid.toString())) {
                    // notify 데이터가 존재한다면
                    if (notifyDatas[c.uuid.toString()]!.isNotEmpty) {
                      cnt++;
                      if (cnt > 50) {
                        disconnectDevice();
                      }
                      if (notifyDatas[c.uuid.toString()]!.contains('\n')) {
                        debugPrint('누적된 블루투스 데이터가 들어옵니다');
                        connectDataState.value = true;
                        coasterData.value = notifyDatas[c.uuid.toString()]!;
                      } else {
                        coasterData.value = bluetoothDataParsing(
                            notifyDatas[c.uuid.toString()]!);
                      }
                    }
                  }
                });
              } catch (e) {
                debugPrint('error ${c.uuid} $e');
              }
            }
            connectDataState.value = false;
          }
        }
      }
    });
  }

  void disconnectDevice() {
    try {
      device.disconnect();
      connectDeviceState.value = "disconnect";
    } catch (e) {
      debugPrint("연결 해제 오류");
    }
  }

  String bluetoothDataParsing(String str) {
    List splitData;

    if (str.contains("w")) {
      type = 'w';
      splitData = str.split(RegExp(r'[w]'));
    } else if (str.contains("c")) {
      type = 'c';
      splitData = str.split(RegExp(r'[c]'));
    } else {
      type = 'd';
      splitData = str.split(RegExp(r'[d]'));
    }

    time = int.parse(splitData[0]);
    water.value = int.parse(splitData[1]);
    debugPrint("시간 : $time, 타입 : $type, 마신 양 : $water");

    return "시간 : $time, 타입 : $type, 양 : $water";
  }
}
