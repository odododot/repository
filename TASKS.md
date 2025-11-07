# TASKS: StockView

- `[ ]`: 미완료
- `[~]`: 진행 중
- `[x]`: 완료

---

### 1. 프로젝트 설정 (Setup)
- [x] Flutter 프로젝트 초기 설정
- [x] Clean Architecture 기반 폴더 구조 생성 (data, domain, presentation)
- [x] `.env` 파일 설정 및 API 키 관리 구성
- [x] 의존성 주입(DI) 기본 설정

### 2. 데이터 계층 (Data Layer)
- [x] 데이터 모델 정의 (e.g., Price, Recommendation)
- [x] 데이터 소스 인터페이스 정의 (Local, Remote)
- [x] 로컬 저장소를 사용한 데이터 소스 구현
- [x] API 통신을 위한 Remote 데이터 소스 구현
- [x] Mock 데이터 소스 구현 (테스트용)
- [x] 데이터 소스를 선택적으로 사용하는 Repository 구현

### 3. 도메인 계층 (Domain Layer)
- [x] 도메인 Entity 정의
- [x] Use Case 정의
    - [x] 데이터 조회 Use Case (e.g., GetStockDataUseCase)
    - [x] 데이터 분석 및 추천 생성 Use Case (e.g., GetRecommendationUseCase)
- [x] 비즈니스 로직 구현
    - [x] 20일 이동평균선 계산 로직
    - [x] 상승 다이버전스 분석 로직

### 4. 프레젠테이션 계층 (Presentation Layer)
- [x] MVVM 패턴 적용
    - [x] ViewModel (`ChangeNotifier` 상속) 구현
    - [x] State Holder 패턴 적용
- [x] 화면(View) 구현
    - [x] 메인 화면 UI 구조 설계
    - [x] `ListenableBuilder`를 사용하여 ViewModel과 UI 연결
    - [x] 상단 그래프 표시 위젯 구현
    - [x] 하단 추천 이유 표시 위젯 구현

### 5. 테스트 (Testing)
- [x] 데이터 계층 유닛 테스트
    - [x] Repository 테스트
    - [x] 데이터 소스 테스트
- [x] 도메인 계층 유닛 테스트
    - [x] Use Case 테스트
    - [x] 비즈니스 로직(전략) 테스트
