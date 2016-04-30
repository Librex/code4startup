#Gitの運用フローについて

Gitの運用フローについて以下まとめていきます

### github-flowで運用していきます。

github-flowについてよくわからない場合にはこのあたりがイメージつけやすいと思うので参考にしてください。
http://b.pyar.bz/blog/2014/01/22/github-flow/

似た名前でもっとシンプルなGit Flowもあるのですが以下理由でgithub-flowでの運用にしてます

* シンプルな形で運用したい

### 実際の作業の流れ

ブランチ作る時には、issueのIDと紐付ける形にしてください。

例えばですが、Let's Encrypt使ってHTTPS対応するというIssueを対応する場合には以下のように、対応してもらえればOKです

git co -b "issue-59"

### 作業の進捗をおおまかに把握したいのでWIPのプルリクエストを最初に作る

空き時間などに作業をしてもらうことを念頭に置いてるので、こまめな進捗報告は特にいらないのですが、少なくとも

```
* 作業を開始したかどうか
* 作業とりかかった後の進捗
```

というのを大まかに把握をしたいので、最初にWIPのプルリクエスト作ってもらってこまめに更新してもらう形にしてもらうとありがたいです。

参考までにWIPのプルリクエスト使った作業フローはこういうやつです

すでにブランチを作って、Let's Encrypt使ってHTTPS対応するというIssueの対応をする場合のgitの作業例を以下簡単にまとめておきます

空のコミット作る

```
git commit --allow-empty -m "[WIP]Let's Encrypt使ってHTTPS対応"
```
pushする

現在のブランチをpushする
```
git push origin ISSUE-59
```

pushした後に、プルリクエスト作ってGitHub上でこれからやる作業についてまとめる

pushした後にGitHubのページにアクセスして、プルリクエストを作ってください。

Issue作る時に、お願いしたいことをなるべく明確にするようにしてますが、ちょっとしたモレとか、互いの認識のズレとかが生まれるかもしれので、そのIssue対応をする上でどんな順番で作業してく予定かおおまかに書いておいてもらえると嬉しいです！（後は何か作業上でわからないことが出た場合にフォローできるため）

[![https://diveintocode.gyazo.com/1d8a760bd508375e7d357e24186b52b7](https://t.gyazo.com/teams/diveintocode/1d8a760bd508375e7d357e24186b52b7.png)](https://diveintocode.gyazo.com/1d8a760bd508375e7d357e24186b52b7)


### WIPについて

* WIP(work in progress) 作業中であることを示す  
* Fixed                 作業完了であることを示す　

### プルリクエストを作成したら
プルリクエスト作成後は、slackでレビュー担当者にメンションをつけて知らせてください。

例

[![https://diveintocode.gyazo.com/6b1d93cd3e1a2b7a6daee8bfb22874aa](https://t.gyazo.com/teams/diveintocode/6b1d93cd3e1a2b7a6daee8bfb22874aa.png)](https://diveintocode.gyazo.com/6b1d93cd3e1a2b7a6daee8bfb22874aa)
