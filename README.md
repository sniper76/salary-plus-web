# salary-plus-web

Salary Plus Web Project

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## 주요 라이브러리

- bloc
- get_it
- auto_route
- multiple_result
- retrofit

## 구조

- clean architecture 적용

```
lib
├── config                          : 앱 테마 및 설정 정보 
├── core                            : 라우터 및 di, service
├── data                            : api client 및 repository
├── domain                          : usecase
└── presentation                    : UI
│   ├── base                  : 공통 bloc
│   ├── bottomsheet            
│   ├── dialog                
│   ├── screen                : 화면들
│   └── widget                : 공통 위젯

```

## dev

### CORS issue on local

- install flutter_cors

```
dart pub global activate flutter_cors
```

- CORS off

```
 fluttercors --disable
```

- CORS on

```
 fluttercors --enable
```

## build for development

### build runner

- route 변경시에도 파일 제너레이팅을 위해 필요.

```
dart run build_runner build --delete-conflicting-outputs
```

### build splash

```
flutter pub run flutter_native_splash:create
```

## run & build

created separate environments using [flavors](https://docs.flutter.dev/deployment/flavors)

### run local

```
flutter run web -t lib/main_local.dart  
```

default api port is set to '8080' <br/><br/>
if you want to run with different api port, add `--dart-define=SERVER_PORT=` option to above command

### run dev

```
flutter run web -t lib/main_dev.dart
```

### run prod

```
flutter run web -t lib/main_prod.dart
```

### repair

```
flutter pub cache repair
```
