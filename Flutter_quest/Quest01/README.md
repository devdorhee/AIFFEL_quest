# AIFFEL Campus Code Peer Review Templete
- 코더 : 이준오
- 리뷰어 : 김주현


# PRT(Peer Review Template)
[X]  **1. 주어진 문제를 해결하는 완성된 코드가 제출되었나요?**
- 문제에서 요구하는 기능이 정상적으로 작동하는지?
  - 추상 클래스, 믹스인, 그리고 그것을 상속받은 PomodoroTimer 클래스 모두 정상적으로 동작하였습니다.
  - 다만, 작업시간+휴식시간을 합쳐서 1회차로 계산해야 하는데, 작업시간, 휴식시간 각각 회차를 증가시키도록 카운트하는 바람에 4회차 시 휴식시간을 5분에서 15분으로 늘리는 부분의 실행까지 확인할 수 없었던 점만 유일하게 아쉬운 부분이었습니다. 
    
[O]  **2. 핵심적이거나 복잡하고 이해하기 어려운 부분에 작성된 설명을 보고 해당 코드가 잘 이해되었나요?**
- 해당 코드 블럭에 doc string/annotation/markdown이 달려 있는지 확인
- 해당 코드가 무슨 기능을 하는지, 왜 그렇게 짜여진건지, 작동 메커니즘이 뭔지 기술.
- 주석을 보고 코드 이해가 잘 되었는지 확인
        
[O]  **3. 에러가 난 부분을 디버깅하여 “문제를 해결한 기록”을 남겼나요? 또는 “새로운 시도 및 추가 실험”을 해봤나요?**
- 문제 원인 및 해결 과정을 잘 기록하였는지 확인
- 문제에서 요구하는 조건에 더해 추가적으로 수행한 나만의 시도, 실험이 기록되어 있는지 확인
  - main 함수 내에서 70초 후 멈추는 코드를 통해 정상 동작 여부를 체크하려는 시도를 하였습니다. 
```
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
```
        
[O]  **4. 회고를 잘 작성했나요?**
- 프로젝트 결과물에 대해 배운점과 아쉬운점, 느낀점 등이 상세히 기록 되어 있나요?
  - 작성한 코드 자체에서 지금까지 배운 추상 클래스, 믹스인 등을 적극적으로 활용하려는 시도 자체가 매우 돋보였습니다.
  - 다른 프로그래밍 언어와 비교했을 때 Dart 언어가 가지는 장점에 대해서도 잘 정리하고 있고, Git 커맨드에 대한 복습도 필요하다는 점에 대해서 잘 회고하고 있습니다. 
        
[O]  **5. 코드가 간결하고 효율적인가요?**
- 파이썬 스타일 가이드 (PEP8)를 준수하였는지 확인
- 코드 중복을 최소화하고 범용적으로 사용할 수 있도록 모듈화(함수화) 했는지
  - 특히, PomodoroTimer 클래스 내에서 start, stop, tick 메소드 3개로 단순화해 작업시간용 타이머 뿐 아니라 휴식시간용 타이머 역시 동일한 tick 메소드 하나로 단순화해 구현한 부분이 가장 인상 깊었습니다. 
```
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
``` 


# 참고 링크 및 코드 개선
```
# 코드 리뷰 시 참고한 링크가 있다면 링크와 간략한 설명을 첨부합니다.
# 코드 리뷰를 통해 개선한 코드가 있다면 코드와 간략한 설명을 첨부합니다.
```

