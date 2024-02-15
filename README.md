## Setup
1:envをルートディレクトリに配置

2:env.g.dartをコマンドにより作成
```
flutter pub run build_runner build --delete-conflicting-outputs
```

## execution
実行

## pubspec.lockに関するerror
1:pubspec.lockの消去
```
rm pubspec.lock
```

2:依存関係の再構築
```
flutter pub get 
```

## その他のerror
1:pubspec.lockの消去
```
flutter clean
```

2:依存関係の再構築
```
flutter pub get 
```



