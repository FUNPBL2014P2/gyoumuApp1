gyoumuApp1
==========
##開発ルール

####issue
* 基本的に小田が発行しメンバーに割り当て
* 割り当てたら担当メンバーに連絡を
* 期限がある場合はコメントに記述
  * 期限内にレビューまで終わるように余裕を持って
* Storyboardの変更はコンフリクト対応が面倒なので基本的に瀬川が担当

####ブランチ
######ブランチの切り方
* ブランチを作る前にmasterを最新の状態にする
* 1つのissue毎に1つのトピックブランチを作る
* トピックブランチは最新のmasterから作る
* リモートに反映させなければ、ローカルで好きに作っても可

######ブランチ名
* 先頭単語以外を除き、単語の先頭は大文字
   * addBadgeBackground
* ブランチ名から作業内容が把握できるように
* あとは個人の裁量に任せる

####プルリク
* 1つのissue毎に1つのトピックブランチを作る
* プルリクコメントにどのissueに対してか分かるようにissueIDを付加
  * 例 : #12 実装しました
* 作業途中で技術的、仕様的に分からない問題があった場合はプルリクタイトルの先頭に[WIP]付加し、疑問点をプルリクコメントに記載  
* プルリクを出したらLINEやSkypeで報告を

####レビュー
* プルリク毎にレビュー
* レビュー担者者は他開発メンバーの2名が行う
  * ソースコードをpullし、トピックブランチに切り替えて、ソースコード、動作確認、仕様との整合性を確認。
* 2名の承認を得られたらプルリクをマージ
  * ただし[WIP]プルリクは承認を必要としない
* マージ担当者はプルリク発行者が担当
* __基本的にレビューは迅速に！__

####マージ後
* 作業担当者がブランチを削除
