import 'package:uuid/uuid.dart';

/// 1 이게 더 알맞음
class UuidUtil {
  /// class 외부에서는 접근할 수 없음
  /// static -> 클래스 레벨에서 공유
  /// 다른 메서드 호출할 때 초기화 하지 않아도 되는 이점
  static const _uuid = Uuid();

  static String uuidGenerator() {
    return _uuid.v1();
  }
}

/// 2
/// 변수의 가시성을 명시적으로 제한하지 않기 때문에 개발자가 실수로 _uuid에 접근할 수 있는 경우가 생길 수 있음 [??]
// const _uuid = Uuid();
//
// class UuidUtil {
//   static String uuidGenerator() {
//     return _uuid.v1();
//   }
// }
