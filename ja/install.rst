=========================
インストール方法
=========================

はじめに
=========================
UNIXにおける一般的なインストール手順（``./configure; make; make install``）により，インストールを行う．

``./configure`` に何もオプションをつけない場合，XcalableMPのみがインストールされる．XcalableACCとOpenACCをインストールする場合，``./configure`` にオプションをつける必要がある． :ref:`general` および :ref:`supercomputer` ではXcalableMPのインストール手順について説明し，:ref:`optional` ではXcalableACCとOpenACCのインストール手順について説明する．

入手方法
=========================
公式サイトから入手する方法とGitHubから入手する方法がある．

公式サイト
-------------
http://omni-compiler.org のトップページから入手できる．
Stable版とNightly Build版がある．
Nightly Build版は，毎日深夜0時ごろ（日本時間）に，GitHub上にある最新リポジトリが前日から更新されていると生成される．

GitHub
--------
下記のコマンドで入手できる．

.. code-block:: bash

  $ git clone --recursive https://github.com/omni-compiler/omni-compiler.git


依存関係のあるソフトウェア
===========================
Omni Compilerのインストールの前に，下記のソフトウェアをインストールする必要がある．

* Yacc
* Lex
* C Compiler (supports C90)
* Fortran Compiler (supports Fortran 90)
* C++ Compiler
* Java Compiler
* MPI Implementation (supports MPI-2 or over)
* libxml2
* make

以下に，主要Linuxディストリビューションにおけるインストール手順について示す．

* Debian GNU/Linux 9.0

.. code-block:: bash

  $ sudo aptitude install flex gcc gfortran g++ openjdk-8-jdk libopenmpi-dev openmpi-bin libxml2-dev byacc make perl

* Ubuntu 18.04

.. code-block:: bash

  $ sudo apt-get install flex gcc gfortran g++ openjdk-8-jdk libopenmpi-dev openmpi-bin libxml2-dev byacc make perl

* CentOS 7.2

.. code-block:: bash

  $ sudo yum install flex gcc gfortran gcc-c++ java-1.7.0-openjdk-devel openmpi-devel libxml2-devel byacc make perl

.. _general:

一般的な手順
=========================

一般的なUNIX環境におけるインストール手順について説明する．

ビルドとインストール
--------------------

.. code-block:: bash

    $ ./configure --prefix=(INSTALL PATH)
    $ make
    $ make install


``(INSTALL PATH)`` には，インストール先を指定する．

.. note::

    ``(INSTALL PATH)`` にはOmni Compilerのソースコードのディレクトリは指定できません．

PATHの設定
--------------------
* bashやzshの場合

.. code-block:: bash

    $ export PATH=(INSTALL PATH)/bin:$PATH

* cshやtcshの場合

.. code-block:: csh

    % setenv PATH (INSTALL PATH)/bin:$PATH


.. _supercomputer:

各スーパーコンピュータの場合
==================================================
``./configure`` に ``--target=(machine name)`` でマシンを指定することにより，下記のスーパーコンピュータに適したOmni Compilerのビルドを行うことができる．

スーパーコンピュータ「京」
----------------------------------------

.. code-block:: bash

    $ ./configure --target=Kcomputer-linux-gnu --prefix=(INSTALL PATH)
    $ make
    $ make install

Fujitsu FX100
----------------------------------------

.. code-block:: bash

    $ ./configure --target=FX100-linux-gnu --prefix=(INSTALL PATH)
    $ make
    $ make install

片側通信の実装に，富士通MPI拡張RDMAではなくMPI Version 3を用いたい場合は， ``./configure`` に ``--disable-fjrdma`` を追加する．

.. code-block:: bash

    $ ./configure --target=FX100-linux-gnu --disable-fjrdma --prefix=(INSTALL PATH)

Fujitsu FX10
--------------------

.. code-block:: bash

    $ ./configure --target=FX10-linux-gnu --prefix=(INSTALL PATH)
    $ make
    $ make install

Intel Knights Landing
----------------------------------------

.. code-block:: bash

    $ ./configure --target=KNL-linux-gnu --prefix=(INSTALL PATH)
    $ make
    $ make install

Intel Knights Corner
----------------------------------------

.. code-block:: bash

    $ ./configure --target=KNC-linux-gnu --prefix=(INSTALL PATH)
    $ make
    $ make install

NEC SX-ACE
--------------------
ログインノードに ``libxml2`` がインストールされていない場合は， `libxml2 <http://www.xmlsoft.org/>`_ をインストールする．

.. code-block:: bash

    $ tar xfz libxml2-git-snapshot.tar.gz
    $ cd libxml2-2.9.2
    $ ./configure --without-python --prefix=(LIBXML2 PATH) 
    $ make
    $ make install

次に，Omni Compilerのインストールを行う．

.. code-block:: bash

    $ ./configure --target=sxace-nec-superux --with-libxml2=(LIBXML2 PATH) --prefix=(INSTALL PATH)
    $ make
    $ make install

NEC SX9
--------------------
.. code-block:: bash

    $ ./configure --target=sx9-nec-superux --prefix=(INSTALL PATH)
    $ make
    $ make install

HITACHI SR16000
--------------------
.. code-block:: bash

    $ bash
    $ export PATH=/opt/freeware/bin/:$PATH
    $ export PATH=/usr/java6/jre/bin/:$PATH
    $ bash ./configure --target=powerpc-hitachi-aix --prefix=(INSTALL PATH)
    $ make
    $ make install

IBM BlueGene/Q
--------------------
ログインノードに ``Java`` がインストールされていない場合は，例えば `OpenJDK <http://cr.openjdk.java.net/~simonis/ppc-aix-port/>`_ の ``openjdk1.7.0-ppc-aix-port-linux-ppc64-b**.tar.bz2`` のインストールを行った後に，Omni Compilerのインストールを行う．

.. code-block:: bash

    $ ./configure --target=powerpc-ibm-cnk --prefix=(INSTALL PATH)
    $ make
    $ make install

.. _optional:

オプショナルな手順
=========================

OpenACCのインストール
----------------------------------------
``--enable-openacc`` を ``./configure`` に付加する．必要に応じてCUDAのインストールパスを ``--with-cuda=(CUDA PATH)`` で設定する．

.. code-block:: bash

    $ ./configure --enable-openacc --with-cuda=(CUDA PATH) 
    $ make
    $ make install

OpenACC用のランタイムを生成する際に利用する ``nvcc`` コマンドにオプションを設定することにより，より適したランタイムを生成できる可能性がある．その場合，``./configure`` に ``--with-gpu-cflags="(NVCC CFLAGS)"`` を付加する．

.. code-block:: bash

    $ ./configure --enable-openacc --with-cuda=(CUDA PATH) --with-gpu-cflags="-arch=sm_20 -O3"

XcalableACCのインストール
----------------------------------------

``--enable-openacc --enable-xacc`` を ``./configure`` に付加する．他はOpenACCと同様である．

.. code-block:: bash

    $ ./configure --enable-openacc --enable-xacc --with-cuda=(CUDA PATH) 
    $ make
    $ make install

PGIコンパイラを使う場合
------------------------
``--with-cuda=(CUDA PATH)`` には，PGIコンパイラに同梱されているCUDAを指定する．ただし，Omni CompilerのビルドにはNVIDIAが提供しているCUDAも必要である．

例えば，PGI Community Edition 16.10を/opt/pgi-1610に，NVIDIAが提供しているCUDA 7.5を/opt/cuda-7.5にインストールしている場合は，下記のように設定を行う．

.. code-block:: bash

    $ export PATH=/opt/cuda-7.5/bin:$PATH
    $ which nvcc
    $ /opt/cuda-7.5/bin/nvcc
    $ ./configure --enable-openacc --enable-xacc --with-cuda=/opt/pgi-1610/linux86-64/2016/cuda/7.5/
    $ make
    $ make install

XcalableMPにおける他の片側通信ライブラリの利用
------------------------------------------------------------
XcalableMPにおいてMPIと他の片側通信ライブラリとを併用することにより，より高速なランタイムを生成することができる場合がある．Omni Compilerは下記の片側通信ライブラリをサポートしている．

* 富士通MPI拡張RDMA
* `GASNet <https://gasnet.lbl.gov/>`_
* MPI Version 3

富士通MPI拡張RDMA
^^^^^^^^^^^^^^^^^^
富士通MPI拡張RDMAは，スーパーコンピュータ「京」，FX100，FX10でのみ利用可能である． ``./configure --target=(machine name)`` を実行することにより，自動的にOmni Compilerは富士通MPI拡張RDMAを利用する．

GASNet
^^^^^^^^^^^^^^^^^^
GASNetは，U.C. Berkeleyが開発している片側通信ライブラリである．GASNetを利用する場合，``./configure`` にGASNetのインストールパスとconduitを指定する．

.. code-block:: bash

    $ ./configure --with-gasnet=(GASNET PATH) --with-gasnet-conduit=(GASNET CONDUIT)

``--with-gasnet-conduit=(GASNET CONDUIT)`` を省略した場合，自動的にOmni Compilerがconduitを選択する．

MPI Version 3
^^^^^^^^^^^^^^^^^^

MPI Version 3は下記の条件が成立した場合，自動的に選択される．

* 利用しているMPIの実装がMPI Version 3に対応している場合
* GASNetを指定しない場合
* スーパーコンピュータ「京」，FX100，FX10以外のマシンの場合

片側通信ライブラリの確認方法
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
omni-compilerがどの片側通信ライブラリが利用するのかは，``./configure`` の最後に出力される **Configuration Summary** で確認することができる．

* 富士通MPI拡張RDMAの場合

.. code-block:: bash

    Onesided                       : yes
      Communication Library        : Fujitsu RDMA

* GASNetの場合

.. code-block:: bash

    Onesided                       : yes
      Communication Library        : GASNet

* MPI Version 3の場合

.. code-block:: bash

    Onesided                       : yes
      Communication Library        : MPI3

* 片側通信ライブラリを利用しない場合

.. code-block:: bash

    Onesided                       : no

Omni Compilerで利用するコンパイラの指定
----------------------------------------
Omni Compilerが利用しているコンパイラは，そのバイナリの利用場所により2種類に分類できる．

* ローカルコンパイラ：Pre-process・Frontend・Translator・Backendに利用する．ローカルコンパイラが生成するバイナリは，Omni Compilerのビルドを行うマシン上（例えばログインノード）で利用される．
* ネイティブコンパイラ：実行ファイルの生成やOmni Compilerのランタイムの生成に利用する．ネイティブコンパイラが生成するバイナリは，計算を行うマシン上で利用される．

.. image:: ../img/flow.png

``./configure`` は上記のコンパイラを自動的に設定するが，ユーザが指定することも可能である．そのための変数は下記の通りである．

* ローカルコンパイラ

+------------+---------------------------+
| 変数       |  意味                     |
+============+===========================+
| CC         | C compiler                |
+------------+---------------------------+
| CFLAGS     | C compiler flags          |
+------------+---------------------------+
| FC         | Fortran compiler          |
+------------+---------------------------+
| FCFLAGS    | Fortran compiler flags    |
+------------+---------------------------+
| JAVA       | Java application launcher |
+------------+---------------------------+
| JAVAC      | Java compiler             |
+------------+---------------------------+
| JAR        | Java Archive Tool         |
+------------+---------------------------+

* ネイティブコンパイラ

+--------------+-------------------------------+
| 変数         | 意味                          |
+==============+===============================+
| MPI_CPP      | C preprocessor                |
+--------------+-------------------------------+
| MPI_CPPFLAGS | C preprocessor flags          |
+--------------+-------------------------------+
| MPI_CC       | C compiler                    |
+--------------+-------------------------------+
| MPI_CFLAGS   | C compiler flags              |
+--------------+-------------------------------+
| MPI_CLIBS    | C compiler linker flags       |
+--------------+-------------------------------+
| MPI_FPP      | Fortran preprocessor          |
+--------------+-------------------------------+
| MPI_FPPFLAGS | Fortran preprocessor flags    |
+--------------+-------------------------------+
| MPI_FC       | Fortran compiler              |
+--------------+-------------------------------+
| MPI_FCFLAGS  | Fortran compiler flags        |
+--------------+-------------------------------+
| MPI_FCLIBS   | Fortran compiler linker flags |
+--------------+-------------------------------+

例えば， ``CC`` に ``icc`` を使いたい場合は， ``./configure CC=icc`` と実行する．

ランタイムに対するBLASの利用
----------------------------------------
Omni Compilerのランタイムの一部には，BLASが利用可能である．例えば，組み込み関数の中の1つである ``xmp_matmul()`` において，行列演算のBLASを利用すると高速に実行が可能になる．

何も指定しない場合（デフォルト）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
ランタイムが用意している内部関数が利用される．

スーパーコンピュータ「京」の場合
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
``./configure --target=Kcomputer-linux-gnu`` を実行することにより，ランタイム内で「京」が提供するBLASが利用される．

FX100もしくはFX10の場合
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
``./configure --enable-SSL2BLAMP`` を実行することにより，ランタイム内でFX100もしくはFX10が提供するBLASが利用される．

Intel MKLを使う場合
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
``./configure --enable-intelmkl`` を実行することにより，ランタイム内でIntel MKLが利用される．

ユーザが指定するBLASを利用する場合
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
``./configure --with-libblas=(BLAS PATH)`` を実行することにより，指定されたBLASが利用される．


Dockerを用いる場合
=====================
Docker Hubに用意しているOmni CompilerのDockerイメージを用いる方法を示す．

.. code-block:: bash

    $ docker run -it -u xmp -w /home/xmp omnicompiler/xcalablemp


