#run this script from Product page in your project Derived Data folder
framework_name="StackOverflowSDK" && \
cp -R Debug-iphoneos/$framework_name.framework ./$framework_name.framework && \
lipo -create -output "$framework_name.framework/$framework_name" \
"Debug-iphonesimulator/$framework_name.framework/$framework_name" \
"Debug-iphoneos/$framework_name.framework/$framework_name" 