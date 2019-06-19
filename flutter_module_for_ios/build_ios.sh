if [ -z $out ]; then
    out='ios_frameworks'
fi

echo "准备输出所有文件到目录: $out"

echo "清除所有已编译文件"
find . -d -name build | xargs rm -rf
flutter clean
rm -rf $out
rm -rf build

flutter packages get

addFlag(){
    cat .ios/Podfile > tmp1.txt
    echo "use_frameworks!" >> tmp2.txt
    cat tmp1.txt >> tmp2.txt
    cat tmp2.txt > .ios/Podfile
    rm tmp1.txt tmp2.txt
}

echo "检查 .ios/Podfile文件状态"
a=$(cat .ios/Podfile)
if [[ $a == use* ]]; then
    echo '已经添加use_frameworks, 不再添加'
else
    echo '未添加use_frameworks,准备添加'
    addFlag
    echo "添加use_frameworks 完成"
fi

echo "编译flutter"
flutter build ios --release --no-codesign

echo "编译flutter完成"
mkdir $out

cp -r build/ios/Release-iphoneos/*/*.framework $out
cp -r .ios/Flutter/App.framework $out
cp -r .ios/Flutter/engine/Flutter.framework $out

echo "复制framework库到临时文件夹: $out"

libpath='../flutter-lib'

rm -rf "$libpath/ios_frameworks"
mkdir $libpath
cp -r $out $libpath

echo "复制库文件到: $libpath"
