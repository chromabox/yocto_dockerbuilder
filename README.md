# yocto_dockerbuilder

Yocto linuxのビルドにはLinux環境が必要ですが、Dockerを使用したほうがいちいちVirtualBoxやVMwareを使ってUbuntuの環境から構築してあーだこうだしなくてもよく、楽なために作成しました。

---
## ・docker imageの構築

１．まずはあなたの環境にあった「Docker」をインストールするべし  
大体1GBほど消費するので、docker imageを格納するストレージの容量も確認すること。
  
２．以下でビルドするための環境イメージを作成する  
`DOCKER_BUILDKIT=1` はあってもなくてもいいけど、あったほうが良い  

```
$ DOCKER_BUILDKIT=1 docker build -t yocto-base .
```

色々取ってくるのでまぁまぁ時間がかかる  
生成されたら確認。それなりにでかいです  
```
$ docker images
REPOSITORY   TAG       IMAGE ID       CREATED          SIZE
yocto-base   latest    7e7bcb57a849   About a minute ago   906MB
ubuntu       20.04     20fffa419e3a   4 weeks ago      72.8MB
```

３．ユーザはとりあえず1000番（多くの場合そのホストで一番始めに登録されたユーザ）として動かして動くかどうか確認  
入れて一通り確認したらexitで抜けること。  
--rmが指定されているので、このコンテナはExitしたら消える  
```
$ docker run --rm -it -u 1000:1000 -v $(pwd):$(pwd) -w ($pwd) --name testes yocto-base
```
   
---
## ・構築したimageでYoctoのビルドをする

まず、このビルド用のコンテナを正式に作成。  
このコンテナは残るので、予めホストでYoctoのオブジェクトを残しておきたい場所に移動しておくこと
```
$ cd /home/iama/yocto/board_name
$ docker run -it -u 1000:1000 -v $(pwd):$(pwd) -w $(pwd) --name board_name_yocto yocto-base
```
あとはいつもどおりDocker内に入ってビルドすれば良い。  

次回以降、もう一度このコンテナに入りたい場合はこうすると入れる
```
$ docker start -i board_name_yocto
```


