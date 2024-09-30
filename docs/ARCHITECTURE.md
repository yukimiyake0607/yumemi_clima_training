# 天気予報の状態管理とアーキテクチャ

## Riverpod導入前

```mermaid
graph TD;
    HomeScreen-->WeatherRequest;
    WeatherRequest-->YumemiWeather;
```

- HomeScreenはweatherRequestに依存しており、WeatherRequestはYumemiWeatherに依存している。
- HomeScreenはWeatherRepositoryのgetWeatherからWeatherConditionResponseを受け取り、setStateを使用して画面の再描画をおこなう。

## Riverpod導入後

```mermaid
flowchart TB
  subgraph Arrows
    direction LR
    start1[ ] -..->|read| stop1[ ]
    style start1 height:0px;
    style stop1 height:0px;
    start2[ ] --->|listen| stop2[ ]
    style start2 height:0px;
    style stop2 height:0px; 
    start3[ ] ===>|watch| stop3[ ]
    style start3 height:0px;
    style stop3 height:0px; 
  end
  subgraph Type
    direction TB
    ConsumerWidget((widget));
    Provider[[provider]];
  end
  HomeScreen((HomeScreen));
  weatherNotifierProvider ==> HomeScreen;
  weatherNotifierProvider --> HomeScreen;
  weatherNotifierProvider[[weatherNotifierProvider]];
```

### HomeScreen
- weatherNotifierProviderをreadして、getWeatherを実行
- weatherNotifierProviderをwatchして、データの取得に成功すると返されたweatherDataを基に画面を更新
- weatherNotifierProviderをlistenして、error時にエラーダイアログを表示