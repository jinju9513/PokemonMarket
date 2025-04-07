<h1 align="center">
🧢 PokemonMarket
</h1>
<p align="center">
</p>
  <img alt="브로셔 이미지" src=""/>
  
![Simulator Screenshot - iPhone 16 Pro Max - 2025-04-07 at 19 51 09](https://github.com/user-attachments/assets/39e4965a-1c77-43cf-a972-7da4832bb416)
![Simulator Screenshot - iPhone 16 Pro Max - 2025-04-07 at 19 51 13](https://github.com/user-attachments/assets/846c891b-2b3d-4927-ae30-0214d5e3309d)
![Simulator Screenshot - iPhone 16 Pro Max - 2025-04-07 at 19 51 42](https://github.com/user-attachments/assets/b35855ca-7425-42b0-bf3c-a167e6e47ffa)
![Simulator Screenshot - iPhone 16 Pro Max - 2025-04-07 at 19 51 45](https://github.com/user-attachments/assets/8fc7c8da-ebf3-4613-bed0-f311f496eedc)
![Simulator Screenshot - iPhone 16 Pro Max - 2025-04-07 at 19 51 48](https://github.com/user-attachments/assets/591f01f8-7ea2-4882-bea3-5bd785fa5e87)
![Simulator Screenshot - iPhone 16 Pro Max - 2025-04-07 at 19 52 02](https://github.com/user-attachments/assets/e3777889-b92e-4a55-b6fa-8146d33cfeb2)
![Simulator Screenshot - iPhone 16 Pro Max - 2025-04-07 at 19 52 13](https://github.com/user-attachments/assets/b9ad0240-898d-406e-af6b-f34a9424de21)
![Simulator Screenshot - iPhone 16 Pro Max - 2025-04-07 at 19 52 34](https://github.com/user-attachments/assets/54438190-33fc-4be4-87a7-29b052d1b493)
![Simulator Screenshot - iPhone 16 Pro Max - 2025-04-07 at 19 52 36](https://github.com/user-attachments/assets/1834e07e-4f92-43e4-b46a-d8811030032b)


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
| :------: |  :------: | :------: | :------: | :------: |

## 🗓️ 프로젝트 일정

2025.04.03 ~ 현재 개발 중

## 🧰 기술 스택

| 분류 | 사용 기술 |
|------|-----------|
| 언어 | Flutter (Dart) |
| 상태관리 | Provider |
| 테마 | CustomTheme, ThemeManager |
| 디자인 | Google Fonts, Material Design |
| 포맷 | intl (통화 및 숫자 포맷팅) |
| 로컬 이미지 | File/Asset 기반 이미지 처리 |
| IDE | VSCode or Android Studio |

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

| 페이지 | 주요 기능 |
|--------|-----------|
| 🛍️ 상품 목록 | 전체 상품 조회 및 간단 정보 보기 |
| 🔍 상품 상세 | 이미지, 이름, 가격, 설명 표시 |
| ➕ 상품 등록 | 이미지 업로드 + 상품 정보 등록 |
| 🔄 카드 교환 페이지 | 유저 간 카드 교환 요청 리스트|
| ✍️ 카드 교환 등록 | 교환할카드와 원하는 카드 등록 |
| 🧾 장바구니 | 수량 조절, 삭제, 총 금액 확인 |
| 🌗 테마 전환 | 다크 / 라이트 모드 토글 |
| 📸 이미지 처리 | assets or File path 지원 |

---

<br/>

## TroubleShooting


<br/>

## 유지보수 및 개선사항

