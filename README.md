<h1 align="center">
🧢 PokemonMarket
</h1>
<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/Provider-000000?style=for-the-badge&logo=provider&logoColor=white" alt="Provider">
</p>

<div align="center" style="display: flex; flex-wrap: nowrap; overflow-x: auto; padding: 10px;">
  <img src="https://github.com/user-attachments/assets/8215e4a0-159c-4fec-8b1e-3483fab36d48" width=135" style="margin: 10px; flex-shrink: 0;">
  <img src="https://github.com/user-attachments/assets/7a09ae0b-de61-4172-aff6-c3e69cf4ca88" width=135" style="margin: 10px; flex-shrink: 0;">
  <img src="https://github.com/user-attachments/assets/74954773-334c-4c67-a0ec-2d236fb84bc9" width=135" style="margin: 10px; flex-shrink: 0;">
  <img src="https://github.com/user-attachments/assets/9b7c46c7-9495-4efd-83d3-aa47c3fbf5ac" width=135" style="margin: 10px; flex-shrink: 0;">
  <img src="https://github.com/user-attachments/assets/26ac9aa4-72e3-406f-9b9b-bdbdee2fc9f8" width=135" style="margin: 10px; flex-shrink: 0;">
  <img src="https://github.com/user-attachments/assets/fb5e7db2-e13b-4634-ac71-8ebe3731046c" width=135" style="margin: 10px; flex-shrink: 0;">
  <img src="https://github.com/user-attachments/assets/931c1770-707e-4741-9925-14172150da41" width=135" style="margin: 10px; flex-shrink: 0;">
  <img src="https://github.com/user-attachments/assets/1030100e-4f9a-4c3c-8fbe-9ad045fcc459" width=135" style="margin: 10px; flex-shrink: 0;">
  <img src="https://github.com/user-attachments/assets/21aac99e-0e9c-41f1-84a8-2dc3de0400c3" width=135" style="margin: 10px; flex-shrink: 0;">
  <img src="https://github.com/user-attachments/assets/3cb1e41c-2fdf-4f18-9105-a6f89c4ae35a" width=135" style="margin: 10px; flex-shrink: 0;">
  <img src="https://github.com/user-attachments/assets/65c15525-7d29-407b-a972-1c34b1d19247" width=135" style="margin: 10px; flex-shrink: 0;">
</div>




## 📌 프로젝트 개요

**PokemonMarket**은 포켓몬 카드 수집가들을 위한 중고 거래 전용 앱입니다.  
Flutter를 기반으로 직관적이고 깔끔한 UI를 제공하며, 다크/라이트 모드 전환 및 장바구니 기능을 중심으로 구현되었습니다.

---

## 💡 이런 분들을 위해 만들어졌어요!

> 📦 포켓몬 카드를 사고팔고 싶지만, 전문 플랫폼이 마땅치 않았던 분들
>
> 🛒 중고거래 경험을 쉽고 깔끔하게 하고 싶은 포켓몬 수집가
>
> 🌙 다크 모드를 선호하는 사용자 인터페이스 취향러!

---

<br/>

## 팀원 구성

| **이정찬** | **전진주** | **이성엽** | **이인혁** | **유제형** |
| :--------: | :--------: | :--------: | :--------: | :--------: |

## 🗓️ 프로젝트 일정

2025.04.03 ~ 현재 개발 중

## 🧰 기술 스택

| 분류        | 사용 기술                     |
| ----------- | ----------------------------- |
| 언어        | Flutter (Dart)                |
| 상태관리    | Provider                      |
| 테마        | CustomTheme, ThemeManager     |
| 디자인      | Google Fonts, Material Design |
| 포맷        | intl (통화 및 숫자 포맷팅)    |
| 로컬 이미지 | File/Asset 기반 이미지 처리   |
| IDE         | VSCode or Android Studio      |

---

## 📂 프로젝트 구조

```
lib/
├── main.dart                     # 앱 진입점
├── pages/                        # 페이지 컴포넌트
│   ├── home_page.dart            # 홈 화면
│   ├── product_add_page.dart     # 상품 등록 페이지
│   ├── product_detail_page.dart  # 상품 상세 페이지
│   ├── edit_product_page.dart    # 상품 수정 페이지
│   ├── cart_page.dart            # 장바구니 페이지
│   ├── shopping_cart.dart        # 장바구니 관리
│   └── card_trade_list.dart      # 카드 교환 목록 페이지
├── widgets/                      # 재사용 가능한 위젯
│   ├── common_text.dart          # 텍스트 위젯
│   ├── common_img.dart           # 이미지 위젯
│   └── common_appbar.dart        # 앱바 위젯
├── theme/                        # 테마 관련 설정
│   ├── custom_theme.dart         # 테마 스타일
│   └── theme_manager.dart        # 테마 상태 관리
└── providers/                    # 상태 관리
    └── like_provider.dart        # 좋아요 기능 관리
```

### 앱 디자인 설계
<p align="center">
 <a href="https://www.figma.com/design/HCP42dNNPpo4oAKIfAQF4j/%EC%A3%BC%ED%8A%B9%EA%B8%B0-%EA%B8%B0%EC%B4%88-_4%EC%A1%B0?node-id=0-1&p=f&t=zW99etInZgrlV73C-0">
<img width="802" alt="image" src="https://github.com/user-attachments/assets/c4232250-30df-4f8b-8696-6b4e9a5488cf">
</p>

### 역할 분담

**이정찬** : 카드 트레이드 등록 페이지

**전진주** : 카드트레이드 리스트 페이지

**이성엽** : 상품 등록 페이지

**이인혁** : 상품 목록 페이지, 상품 상세 페이지

**유제형** : 장바구니 페이지

<br/>

## 🎨 앱 주요 기능

| 페이지              | 주요 기능                        |
| ------------------- | -------------------------------- |
| 🛍️ 상품 목록        | 전체 상품 조회 및 간단 정보 보기 |
| 🔍 상품 상세        | 이미지, 이름, 가격, 설명 표시    |
| ➕ 상품 등록        | 이미지 업로드 + 상품 정보 등록   |
| 🔄 카드 교환 페이지 | 유저 간 카드 교환 요청 리스트    |
| ✍️ 카드 교환 등록   | 교환할카드와 원하는 카드 등록    |
| 🧾 장바구니         | 수량 조절, 삭제, 총 금액 확인    |
| 🌗 테마 전환        | 다크 / 라이트 모드 토글          |
| 📸 이미지 처리      | assets or File path 지원         |

---

## 🚀 주요 기술적 특징

### 1. 상태 관리

- Provider 패턴을 활용한 효율적인 상태 관리
- 장바구니, 좋아요 등 사용자 상호작용 데이터 관리

### 2. UI/UX

- Material Design 3 기반의 모던한 디자인
- 다크/라이트 모드 지원으로 사용자 편의성 향상
- 애니메이션 효과를 통한 부드러운 사용자 경험

### 3. 성능 최적화

- const 키워드를 활용한 위젯 최적화
- 이미지 캐싱 및 지연 로딩 구현
- 불필요한 리빌드 방지를 통한 성능 개선

### 4. 코드 품질

- 일관된 코드 스타일과 네이밍 컨벤션
- 재사용 가능한 컴포넌트 설계
- 주석을 통한 코드 문서화

---

## 📱 앱 설치 및 실행 방법

1. Flutter 개발 환경 설정

```bash
flutter doctor
```

2. 의존성 설치

```bash
flutter pub get
```

3. 앱 실행

```bash
flutter run
```

---

## 🤝 기여 방법

1. 이 저장소를 Fork합니다.
2. 새로운 브랜치를 생성합니다 (`git checkout -b feature/amazing-feature`).
3. 변경사항을 커밋합니다 (`git commit -m 'Add some amazing feature'`).
4. 브랜치에 푸시합니다 (`git push origin feature/amazing-feature`).
5. Pull Request를 생성합니다.

---

## 📄 라이센스

이 프로젝트는 MIT 라이센스를 따릅니다. 

---

## 🙏 감사의 말

- Flutter 팀에게 감사드립니다.
- 모든 기여자분들께 감사드립니다.
- 포켓몬 팬 여러분들께 감사드립니다.

---

<br/>

