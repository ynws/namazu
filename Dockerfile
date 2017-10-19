FROM ubuntu

# namazu2 : 全文検索システム
# namazu2-index-tools : 全文検索インデックス作成
# nkf    : 日本語変換
# kakasi : 日本語解析
# xpdf   : pdf
# wv     : word
# wget/gcc/make : excel/ppt build
RUN apt-get update && \
    apt-get install -y \
                    namazu2 \
                    namazu2-index-tools \
                    nkf \
                    kakasi \
                    xpdf \
                    wv \
                    wget \
                    gcc  \
                    make  \
                    && \
    rm -rf /var/lib/apt/lists/*

# pdf jp
RUN cd /usr/local/src && \
    wget http://www.xpdfreader.com/dl/xpdf-japanese.tar.gz && \
    tar xvfz xpdf-japanese.tar.gz && \
    cd xpdf-japanese && \
    mkdir -p /usr/local/share/xpdf/japanese && \
    cp -R * /usr/local/share/xpdf/japanese && \
    cat add-to-xpdfrc >> /usr/local/etc/xpdfrc

# excel, ppt
RUN cd /usr/local/src && \
    wget http://www.asahi-net.or.jp/~yw3t-trns/namazu/xlhtml/xlhtml-0.5.1.tar.gz && \
    tar xvfz xlhtml-0.5.1.tar.gz && \
    cd xlhtml && \
    ./configure && \
    make && \
    make install

RUN locale-gen ja_JP.EUC-JP
RUN mkdir /mnt/windows /home/index /home/www
