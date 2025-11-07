# StockView (코인 매수 추천 앱)

## 목표
- 특정 전략을 기반으로 코인 매수 시점을 추천
- 전략: 20일 이동평균선, 상승 다이버전스
- UI: 상단 그래프, 하단 추천 이유

## 기술 스택 및 아키텍처
- **Platform:** Flutter
- **Architecture:** Clean Architecture, MVVM, SOLID 원칙 준수
- **State Management:** `ChangeNotifier` + `ListenableBuilder` 사용 (외부 라이브러리 금지), State Holder 패턴
- **Data Handling:**
    - API 키는 `.env` 파일로 관리
    - 로컬 저장소만 사용
    - DI를 통해 Mock 데이터와 실제 데이터 교체 가능 구조
- **Testing:** 데이터 로직 유닛 테스트 작성

## 제약사항
- 인증 기능 없음
- 실제 매매 기능 없음
- 지정된 전략 외 다른 전략 미포함
