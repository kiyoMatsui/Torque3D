#!/bin/bash
template=""
appName=${PWD##*/}
if [ -z "$1" ]; then
   template="kiyoBareBones"
else
   template=$1
fi
echo using template $template
echo this scripts argument becomes template name

echo "#!/bin/bash" > reindexRtags.sh
echo "rm -r rtagsDir" >> reindexRtags.sh
echo "rdm &" >> reindexRtags.sh
echo "mkdir rtagsDir && cd rtagsDir" >> reindexRtags.sh
#CMAKE_BUILD_TYPE=Release or CMAKE_BUILD_TYPE=Debug
echo "cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DTORQUE_APP_NAME=$appName -DCMAKE_BUILD_TYPE=Release -DTORQUE_TEMPLATE=$template ../../.." >> reindexRtags.sh
echo "rc -J" >> reindexRtags.sh

mkdir build && cd build
cmake -DTORQUE_APP_NAME=$appName -DCMAKE_BUILD_TYPE=Release -DTORQUE_TEMPLATE=$template ../../..
make
make install


