FROM openjdk:8-jdk

RUN apt-get --quiet update --yes
RUN apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1
RUN wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip
RUN unzip -d android-sdk-linux android-sdk.zip
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "platform-tools" >/dev/null
RUN echo y | android-sdk-linux/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null
RUN export ANDROID_HOME=$PWD/android-sdk-linux
RUN export PATH=$PATH:$PWD/android-sdk-linux/platform-tools/
RUN chmod +x ./gradlew
RUN set +o pipefail
RUN yes | android-sdk-linux/tools/bin/sdkmanager --licenses
RUN set -o pipefail
