FROM nvidia/cuda

RUN apt-get update && \
    apt-get install -y cmake libncurses5-dev libncursesw5-dev git && \
    rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/local/cuda-10.1/targets/x86_64-linux/lib/stubs/libnvidia-ml.so /usr/local/lib/libnvidia-ml.so && \
    ln -s /usr/local/cuda-10.1/targets/x86_64-linux/lib/stubs/libnvidia-ml.so /usr/local/lib/libnvidia-ml.so.1 && \
    cd /tmp && \
    git clone https://github.com/Syllo/nvtop.git && \
    mkdir -p nvtop/build && cd nvtop/build && \
    cmake .. && \
    make && \
    make install && \
    cd / && \
    rm -r /tmp/nvtop && \
    rm /usr/local/lib/libnvidia-ml.so && \
    rm /usr/local/lib/libnvidia-ml.so.1

ENTRYPOINT ["/usr/local/bin/nvtop"]