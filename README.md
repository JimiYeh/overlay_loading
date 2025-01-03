# Overlay Loading

這是一個 Flutter 示例專案,展示如何使用 Overlay 實現全螢幕載入效果。

## 專案說明

這個專案展示了一種替代傳統 Dialog 的方法,使用 Overlay 來實現載入畫面。主要特點:

- 使用 Overlay 而不是 Dialog 來顯示載入畫面
- 實現全螢幕半透明遮罩效果
- 可自訂載入訊息文字
- 支援動態更新載入訊息
- 防止使用者在載入時進行其他操作

## 主要功能

- LoadingScreen 單例模式實現
- 支援顯示/隱藏載入畫面
- 可更新載入訊息
- 使用 StreamBuilder 實現動態文字更新

## 使用方法

顯示載入畫面:

LoadingScreen().show(context: context, text: 'Loading...');

隱藏載入畫面:

LoadingScreen().hide();

更新載入訊息:

LoadingScreen().update(text: 'Loading...');
