# 원티드 프리온보딩 코스 백엔드 선발과제

***

## [과제 개요](https://docs.google.com/document/d/1Wu429EZ9tR72ITb5u_5wCfw8s5_U_07a01rWEFZiKyQ/edit)

### 필수 기술요건

* Django ORM or SQLAlchemy 등 ORM을 사용하여 구현.
* REST API 로 구현(Json response).
* RDBMS 사용 (SQLite, PostgreSQL 등).
* Backend 이외의 요소 개발 하지 않음(html, css, js 등)
  * 개발 범위에 제외된다는 의미이며, 구현시에 불이익은 없습니다. 다만, 평가에 이점 또한 없습니다.
  
### 평가요소

* 코드 효율성
* 모델링
* 요구사항 구현정도
* REST API 설계 적합성
* 코드 가독성 및 코드 컨벤션

### 가산점 요소

* Unit Test 구현
* README 에 요구사항 분석 및 구현 과정을 작성
* Git commit 메시지 컨벤션

#### 추가설명

* 요구사항 및 필수기술을 모두 구현하지 않더라도, 구현 정도에 따라 점수가 부여됩니다.
* 요구사항 이외 요소는 평가에 포함되지 않습니다. (인증, 권한 등)

***

## 과제 요구사항

### 서비스 설명

* 본 서비스는 크라우드 펀딩 기능을 제공합니다. 게시자는 크라우드 펀딩을 받기위한 상품(=게시물)을 등록합니다.
* 유저는 해당 게시물의 펀딩하기 버튼을 클릭하여 해당 상품 ‘1회펀딩금액’ 만큼 펀딩합니다.

### 요구 사항

* 상품을 등록합니다.
  * 제목, 게시자명, 상품설명, 목표금액, 펀딩종료일, 1회펀딩금액로 구성.

* 상품을 수정합니다.
  * 단, 모든 내용이 수정 가능하나 '목표금액'은 수정이 불가능합니다.

* 상품을 삭제합니다.
  * DB에서 삭제됩니다.

* 상품 목록을 가져옵니다.
  * 제목, 게시자명, 총펀딩금액, 달성률 및 D-day(펀딩 종료일까지) 가 포함되어야 합니다.

* 상품 검색 기능 구현
  * (상품 리스트 API 에 ?search=취미 조회 시 ,제목에  ‘내 취미 만들..’  ‘취미를 위한 ..’ 등 검색한 문자 포함된 상품 리스트만 조회)
* 상품 정렬 기능 구현
  * 생성일기준, 총펀딩금액 두 가지 정렬이 가능해야합니다. 
 ?order_by=생성일 / ?order_by=총펀딩금액
  * (달성률: 1,000,000원 목표금액 일때,  총 펀딩금액이 5,000,000원 이면 500%, 소수점 무시)

* 상품 상세 페이지를 가져옵니다.
  * 제목, 게시자명, 총펀딩금액, 달성률, D-day(펀딩 종료일까지), 상품설명, 목표금액  및 참여자 수 가 포함되어야 합니다.

***

## 과제 진행 사항

### 사용 기술 스택
<div> 
 <img src="https://img.shields.io/badge/Python 3.9.7-3776AB?style=for-the-badge&logo=Python&logoColor=white">
 <img src="https://img.shields.io/badge/Django 4.0.4-092E20?style=for-the-badge&logo=Django&logoColor=white">
 <img src="https://img.shields.io/badge/MySQL 8.0.28-4479A1?style=for-the-badge&logo=MySQL&logoColor=white">
 <img src="https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=Git&logoColor=white">
 <img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=GitHub&logoColor=white">
 <img src="https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=Postman&logoColor=white">
</div>

### 모델링

![](https://velog.velcdn.com/images/gshduet/post/2543c872-82cb-494e-84fa-30b0837d7cde/image.png)

### API 명세서

[API 명세서 링크](https://documenter.getpostman.com/view/18212355/Uyr5oJw6#904caa8b-f202-4f3b-9a5d-a08346a6c2b2)

### 요구사항 분석

* 후원을 기획한 상품을 기준으로 해당 자원에 관한 전반적인 CRUD를 요구하고 있다고 판단 했으며 이를 중점으로 기능을 구현

* 검색과 정렬 기능을 포함한 상품 리스트 조회 기능 구현

* 해당 서비스를 이용하는 사용자의 입장에서 서비스 이용 흐름을 따라 `유저`와 `후원` 정보에 대한 기능을 임의로 추가 구현

*** 

### 구현 기능

#### 유저 회원가입 및 로그인 API

* POST /users/signup (회원가입)

  * 회원가입 시 아이디, 비밀번호를 요구하며 둘 중 하나라도 입력되지 않았을 경우 에러 반환
  * 유저가 사용하고자 하는 아이디는 알파벳으로 시작하며 알파벳, 숫자, 일부 특수문자('-', '_', '.')을 사용한 8\~15자를, 비밀번호는 알파벳, 숫자, 일부 특수문자를 사용한 8\~20자를 사용
  * 해당 내용은 정규식을 통해 검증. 만약 프론트사이드도 존재했다면 백-프론트 이중 검증을 진행
  * 두 조건 모두 만족한다면 bcrypt를 통해 유저의 비밀번호를 암호화 하여 DB에 저장
  * 유저가 사용하고자 하는 아이디가 이미 존재할 경우를 가정해 서버단에서 미리 `User.objects.filter(name=name).exists()` 를 통해 존재 유무를 판별, 중복 된 아이디라면 에러 반환
  
* POST /users/signin (로그인)

  * 로그인 시 아이디, 비밀번호를 요구하며 둘 중 하나라도 입력되지 않았을 경우 에러 반환
  * 유저가 입력한 아이디가 DB에 존재하지 않을 경우 에러 반환
  * 유저가 로그인 하기 위해 입력한 비밀번호와 DB에 저장 된 비밀번호를 같은 알고리즘을 통해 암호화 해 비교 후 일치하지 않을 경우 에러 반환
  * 입력한 아이디와 비밀번호 모두 일치할 경우 jwt를 통해 생성한 토큰과 로그인 성공 status_code를 프론트 사이드로 반환
  * 후에 로그인 상태를 검증하기 위한 로그인 데코레이터 작성

#### 상품 등록 API

* POST /products/upload (상품 등록)

  * 제목, 게시자명, 상품설명, 목표금액, 펀딩종료일, 1회펀딩금액 입력 가능
  * 해당 상품에 일대일 관계로 연결 된 `Detail` 테이블에 관련 로우 추가
  
#### 상품 상세정보 관리 API

* GET /products/<int:product_id> (상품 상세정보 조회)

  * url을 통해 받은 product_id를 바탕으로 해당 product의 상세정보 호출
  * 제목, 게시자명, 총펀딩금액, 달성률, D-day(펀딩 종료일까지), 상품설명, 목표금액  및 참여자 수
  * is_delete(BooleanType) 컬럼의 True or False 여부를 확인해 해당 상품의 삭제 여부를 확인하고 삭제되지 않은 게시물일 경우만 호출이 됨
  
* PATCH /products/<int:product_id> (상품 상세정보 수정)

  * 토큰을 통해 해당 상품의 수정 인가여부 확인
  * 인가된 사용자일 경우 '목표 금액'을 제외한 정보 수정 가능
  
* DELETE /products/<int:product_id> (상품 삭제)

  * 토큰을 통해 해당 상품의 삭제 인가여부 확인
  * 인가된 사용자일 경우 해당 상품 삭제 가능
  * 상품 삭제 시 해당 상품에 이미 후원한 후원자 정보를 수정, 후원이 자동으로 취소
  * `delete_at`과 `is_delete` 컬럼을 최신화 해 사용자에게 노출시키지 않는 `soft_delete` 방식으로 구현
  
#### 상품 리스트 조회 API

* GET /products (상품 리스트 조회)

  * Q객체를 통한 검색 및 정렬 기능 구현
  * DB 및 서버 부하 감소를 목적으로 pagination을 추가, 상품 리스트 조회 시 출력 할 데이터의 양을 조절 
  
### 유닛테스트

#### 유저 회원가입 및 로그인 API 유닛테스트

![](https://velog.velcdn.com/images/gshduet/post/e0f0440b-754f-49f4-903b-3b68d54822e2/image.png)

통과 완료
