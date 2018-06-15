# Fix for Android Emulator Bug with libstdc++

0. Assuming sdk is in $SDK\_HOME
1. Back up libs delivered with android sdk:
2. Link system libs
3. Do the same for lib32
```
mkdir $ANDROID_HOME/emulator/lib64/libstdc++/old
mv $ANDROID_HOME/emulator/lib64/libstdc++/* $ANDROID_HOME/emulator/lib64/libstdc++/old
ln -s /usr/lib/libstdc++.so.6 $ANDROID_HOME/emulator/lib64/libstdc++/
ln -s /usr/lib/libstdc++.so.6.0.* $ANDROID_HOME/emulator/lib64/libstdc++/

mkdir $ANDROID_HOME/emulator/lib/libstdc++/old
mv $ANDROID_HOME/emulator/lib/libstdc++/* $ANDROID_HOME/emulator/lib/libstdc++/old
ln -s /usr/lib32/libstdc++.so.6 $ANDROID_HOME/emulator/lib/libstdc++/
ln -s /usr/lib32/libstdc++.so.6.0.* $ANDROID_HOME/emulator/lib/libstdc++/
```
