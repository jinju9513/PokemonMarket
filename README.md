<h1 align="center">
🧢 PokemonMarket
</h1>
<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/Provider-000000?style=for-the-badge&logo=provider&logoColor=white" alt="Provider">
</p>

<div align="center">
  <img src="https://github.com/user-attachments/assets/39e4965a-1c77-43cf-a972-7da4832bb416" width="200" style="margin: 10px">
  <img src="https://github.com/user-attachments/assets/846c891b-2b3d-4927-ae30-0214d5e3309d" width="200" style="margin: 10px">
  <img src="https://github.com/user-attachments/assets/b35855ca-7425-42b0-bf3c-a167e6e47ffa" width="200" style="margin: 10px">
  <br>
  <img src="https://github.com/user-attachments/assets/8fc7c8da-ebf3-4613-bed0-f311f496eedc" width="200" style="margin: 10px">
  <img src="https://github.com/user-attachments/assets/591f01f8-7ea2-4882-bea3-5bd785fa5e87" width="200" style="margin: 10px">
  <img src="https://github.com/user-attachments/assets/e3777889-b92e-4a55-b6fa-8146d33cfeb2" width="200" style="margin: 10px">
  <br>
  <img src="https://github.com/user-attachments/assets/b9ad0240-898d-406e-af6b-f34a9424de21" width="200" style="margin: 10px">
  <img src="https://github.com/user-attachments/assets/54438190-33fc-4be4-87a7-29b052d1b493" width="200" style="margin: 10px">
  <img src="https://github.com/user-attachments/assets/1834e07e-4f92-43e4-b46a-d8811030032b" width="200" style="margin: 10px">
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
 <a href="">
<img width="802" alt="image" src="">
</p>

### 역할 분담

**이정찬** :

**전진주** :

**이성엽** :

**이인혁** :

**유제형** :

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

이 프로젝트는 MIT 라이센스를 따릅니다. 자세한 내용은 [LICENSE](LICENSE) 파일을 참조하세요.

---

## 🙏 감사의 말

- Flutter 팀에게 감사드립니다.
- 모든 기여자분들께 감사드립니다.
- 포켓몬 팬 여러분들께 감사드립니다.

---

<br/>

## TroubleShooting

<br/>

## 유지보수 및 개선사항
