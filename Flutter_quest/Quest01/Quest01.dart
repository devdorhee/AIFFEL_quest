import 'dart:async';

// 추상 클래스 -> 나중에 메서드를 정의하겠다.
abstract class TimerTask {
  void start();
  void stop();
  void tick();
}

// 믹스인 -> 기능 합성
mixin TimerHelper {
  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}

// TimerTask를 구현하고 TimerHelper를 사용하는 구체 클래스
class PomodoroTimer extends TimerTask with TimerHelper {
  static const int workTime = 25 * 60; // 25분을 초 단위로 변환
  static const int shortBreakTime = 5 * 60; // 5분을 초 단위로 변환
  static const int longBreakTime = 15 * 60; // 15분을 초 단위로 변환
  static const int repeatCount = 4; // 몇 cycle 돌릴건지?

  Timer? _timer;
  int _remainingTime = workTime;
  int _cycleCount = 0;
  bool _isWorking = true;

  @override
  void start() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      tick();
    });
    print('Pomodoro 타이머를 시작합니다.');
  }

  @override
  void stop() {
    _timer?.cancel();
    _remainingTime = workTime;
    _cycleCount = 0;
    _isWorking = true;
    print('타이머가 멈췄습니다. 초기 상태로 리셋되었습니다.');
  }

  @override
  void tick() {
    if (_remainingTime > 0) {
      _remainingTime--;
      print('남은 시간: ${formatTime(_remainingTime)}');
    } 
    else {
      _cycleCount++;
      if (_isWorking) {
        if (_cycleCount % 4 == 0) {
          _remainingTime = longBreakTime;
          print(
              '작업 시간이 종료되었습니다. ${_cycleCount}회차 $longBreakTime분 휴식 시간을 시작합니다.');
        } 
        else {
          _remainingTime = shortBreakTime;
          print(
              '작업 시간이 종료되었습니다. ${_cycleCount}회차 $shortBreakTime분 휴식 시간을 시작합니다.');
        }
      } 
      else {
        // 반복횟수가 되면 동작하지 않게 함.
        if (_cycleCount < repeatCount) {
          _remainingTime = workTime;
          print('휴식 시간이 종료되었습니다. ${_cycleCount}회차 $workTime분 작업 시간을 시작합니다.');
        }
      }
      _isWorking = !_isWorking;

      // 4회차가 끝나면 타이머 멈춤
      if (_cycleCount == 4) {
        print('${_cycleCount}회차 사이클이 종료되었습니다. 타이머를 멈춥니다.');
        stop();
      }
    }
  }
}

// Pomodoro Timer를 시연하기 위한 메인 함수
void main() {
  PomodoroTimer timer = PomodoroTimer();

  // 타이머 시작
  timer.start();

  // 70초 후 멈춤 (실제 사용에서는 각 시간 주기를 더 길게 설정할 것)
//   Future.delayed(Duration(seconds: 70), () {
//     timer.stop();
//   });
}
