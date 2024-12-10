# [株式会社ゆめみ Flutter研修](https://github.com/yumemi-inc/flutter-training-template)

<img src="https://img.shields.io/badge/-Dart-02569B.svg?logo=dart&style=plastic"> <img src="https://img.shields.io/badge/-Flutter-02569B.svg?logo=flutter&style=plastic">

## 概要
[YumemiWeather API](https://yumemi-inc.github.io/flutter-training-template/)を利用して天気情報を表示するアプリです。株式会社ゆめみのFlutterエンジニアコードチェック課題の要件を満たすように実装しています。
本アプリを通して自分なりの最適なアーキテクチャを確立することを目的としています。

## 天気予報アプリ
| 初期状態 | ローディング時 |
|:---:|:---:|
| <img src="assets/image01.png" width="230"> | <img src="assets/image02.png" width="230"> |

| 天気取得時 | エラー時 |
|:---:|:---:|
| <img src="assets/image03.png" width="230"> | <img src="assets/image04.png" width="230"> |

<p align="center">
  <img src="assets/movie01.gif" width="230">
</p>

## 環境構築
### リポジトリをクローン
```bash
git clone https://github.com/yukimiyake0607/yumemi_clima_training.git
```
### ディレクトリを移動
```bash
cd flutter_training
```
### fvmをインストール
```bash
brew tap leoafarias/fvm
brew install fvm
```
### プロジェクトで指定されたバージョンのFlutterをインストール
```bash
fvm use
```
### Lefthookをインストール
```bash
brew install lefthook
lefthook install
```
### パッケージをインストール
```bash
fvm flutter pub get
```

## Docs
[docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)

## フォルダ構成
<pre>
lib
├── data
│   ├── provider
│   │   ├── weather_notifier_provider.dart
│   │   └── weather_notifier_provider.g.dart
│   ├── repository
│   │   ├── weather_repository.dart
│   │   └── weather_repository.g.dart
│   └── usecase
│       ├── weather_usecase.dart
│       └── weather_usecase.g.dart
├── main.dart
├── models
│   ├── error
│   │   └── custom_weather_error.dart
│   ├── request
│   │   ├── weather_request.dart
│   │   ├── weather_request.freezed.dart
│   │   └── weather_request.g.dart
│   ├── response
│   │   ├── weather_response.dart
│   │   ├── weather_response.freezed.dart
│   │   └── weather_response.g.dart
│   ├── result
│   │   ├── result.dart
│   │   └── result.freezed.dart
│   └── weather
│       ├── weather_condition.dart
│       └── weather_request.dart
└── ui
    ├── extensions
    │   ├── api_error_ext.dart
    │   └── weather_condition_ext.dart
    ├── mixins
    │   └── navigate_to_homescreen_mixin.dart
    ├── screens
    │   ├── home_screen.dart
    │   └── loading_screen.dart
    └── widgets
        ├── button_row.dart
        ├── temperature_row.dart
        └── weather_widget.dart
├
</pre>

### ファイル分割の方針
基本的に関心事ごとにファイルを分割しています。例えば、実際に目に触れるものはすべてUIフォルダに保管しています。ファイル名は関心事.dartとします。

## 環境
|  | バージョン |
|:---:|:---:|
| Dart | 3.5.1 |
| Flutter | 3.24.1 |

## CI
[GitHub Actions](https://github.co.jp/features/actions)を利用してCIを構築しています。
プルリクエストが作成や更新されたときにCIが発火します。