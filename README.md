## Study Lucene
This repo shows how to successfully build and run Lucene versions from [v1.9](https://archive.apache.org/dist/lucene/java) to [v2.9.4](https://lucene.apache.org/core/2_9_4/fileformats.html) and all the way to [v3.4](https://kandepet.com/dissecting-lucene-the-index-format).
The purpose of this repo is to let myself get hands dirty and to be able to actually run old code to gain a good sense in Lucene source code.

Although I fail to build earlier versions before v1.9, I find it helpful (with the help of `gitk`) to study Lucene source code by walking through history. The earliest point I suggest to start reading is the first time Doug Cutting shows up in commit history (b08e28c3838e7bcab1a198e2f6d0cef687ee50e3).

### Setup (Use `v1.9` as Example)
1. Clone lucene-solr:
```sh
$ git clone https://gitee.com/t-k-/lucene-solr.git
$ export LUCENE_SRC=`pwd/lucene-solr`
$ (cd $LUCENE_SRC && git co releases/lucene/1.9)
```

2. Download an old Ant distribution:
```sh
$ cd $LUCENE_SRC
$ wget https://archive.apache.org/dist/ant/binaries/apache-ant-1.8.4-bin.tar.bz2
$ tar -xzf apache-ant-1.8.4-bin.tar.gz
```

3. Pull and run in an old JDK environment:
The earliest jdk environment I can find ...
```sh
$ docker pull maven:3-jdk-6
$ docker run -it \
	-v $LUCENE_SRC:/lucene \
	-e JAVA_HOME=/usr/lib/jvm/java-1.6.0-openjdk-amd64 \
	-e ANT_HOME=/lucene/apache-ant-1.8.4 \
	maven:3-jdk-6 bash
```

4. Build and run Lucene demo
In Docker environment,
```sh
$ export PATH=$PATH:${ANT_HOME}/bin
$ cd /lucene
$ rm -rf build index
$ ant jar-core jar-demo
$ export CLASSPATH=`pwd`/build
$ (cd $CLASSPATH && find -name '*.jar' -exec jar -xf {} \;)
```
Now, let's run the Lucene demo
```sh
$ java org.apache.lucene.demo.IndexFiles ./src/java/
$ java org.apache.lucene.demo.SearchFiles
```

### Build and Run on Docker
```sh
$ sudo docker build -t study-lucene .
$ sudo docker run -it study-lucene java org.apache.lucene.demo.SearchFiles
```

You may want to attach live source code and build in container:
```sh
$ sudo docker run -it -v `pwd`/src/lucene-solr:/code/lucene study-lucene bash
```

Index a large corpus from container?
```sh
$ sudo docker run -it -v /home/tk/nvme0n1/corpus:/corpus study-lucene java org.apache.lucene.demo.IndexFiles /corpus
```
