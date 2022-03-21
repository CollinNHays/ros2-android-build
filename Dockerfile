FROM ubuntu:20.04

ENV ANDROID_NDK_VERSION android-ndk-r23b
ENV ANDROID_TARGET android-21
ENV ANDROID_ABI arm64-v8a
ENV ANDROID_TOOLCHAIN_NAME aarch64-linux-android

ENV ANDROID_NDK /opt/android/${ANDROID_NDK_VERSION}
ENV CMAKE_TOOLCHAIN_FILE=${ANDROID_NDK}/build/cmake/android.toolchain.cmake
ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update
RUN apt install -y git vim cmake build-essential openjdk-8-jdk
RUN apt install -y unzip wget gradle python3-pip
RUN pip3 install -U colcon-common-extensions vcstool lark colcon-ros-gradle

RUN wget -O /tmp/android-ndk.zip https://dl.google.com/android/repository/${ANDROID_NDK_VERSION}-linux.zip && mkdir -p /opt/android/ && cd /opt/android/ && unzip -q /tmp/android-ndk.zip && rm /tmp/android-ndk.zip

RUN mkdir -p /root/workspace/src

COPY ./build-android.sh /root/workspace/
RUN chmod +x /root/workspace/build-android.sh

