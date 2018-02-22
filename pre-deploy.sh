#!/bin/bash

OUTDIR=$TRAVIS_BUILD_DIR/out/$TRAVIS_PULL_REQUEST/$TRAVIS_JOB_NUMBER-$HOST
mkdir -p $OUTDIR/bin

if [[ $HOST = "i686-w64-mingw32" ]]; then
  ARCHIVE_NAME="windows-x86.zip"
elif [[ $HOST = "x86_64-w64-mingw32" ]]; then
    ARCHIVE_NAME="windows-x64.zip"
elif [[ $HOST = "arm-linux-gnueabihf" ]]; then
    ARCHIVE_NAME="arm-x86.zip"
elif [[ $HOST = "aarch64-linux-gnu" ]]; then
    ARCHIVE_NAME="arm-x64.zip"
elif [[ $HOST = "x86_64-unknown-linux-gnu" ]]; then
    ARCHIVE_NAME="linux-x64.zip"
elif [[ $HOST = "x86_64-apple-darwin11" ]]; then
    ARCHIVE_NAME="osx-x64.zip"
fi

cp $TRAVIS_BUILD_DIR/src/qt/hexxcoin-qt $OUTDIR/bin/ || cp $TRAVIS_BUILD_DIR/src/qt/hexxcoin-qt.exe $OUTDIR/bin/ || echo "no QT Wallet"
cp $TRAVIS_BUILD_DIR/src/hexxcoind $OUTDIR/bin/ || cp $TRAVIS_BUILD_DIR/src/hexxcoind.exe $OUTDIR/bin/
cp $TRAVIS_BUILD_DIR/src/hexxcoin-cli $OUTDIR/bin/ || cp $TRAVIS_BUILD_DIR/src/hexxcoin-cli.exe $OUTDIR/bin/
strip "$OUTDIR/bin"/* || echo "nothing to strip"
ls -lah $OUTDIR/bin

cd $OUTDIR/bin
zip $ARCHIVE_NAME *

mkdir -p $OUTDIR/zip
mv $ARCHIVE_NAME $OUTDIR/zip

sleep $[ ( $RANDOM % 6 )  + 1 ]s
