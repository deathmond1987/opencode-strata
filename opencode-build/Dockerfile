FROM alpine:latest

ENV LANG=C.UTF-8 \
    PIP_BREAK_SYSTEM_PACKAGES=1 \
    NPM_CONFIG_UPDATE_NOTIFIER=false \
    NPM_CONFIG_FUND=false \
    OPENCODE_DISABLE_AUTOUPDATE=true \
    XDG_DATA_HOME=/home/opencode-dev/.local/share \
    XDG_CONFIG_HOME=/home/opencode-dev/.config \
    XDG_CACHE_HOME=/home/opencode-dev/.cache \
    PYTHONPATH=

RUN apk add --no-cache \
        bash \
        curl \
        wget \
        ca-certificates \
        unzip \
        tar \
        gzip \
        bzip2 \
        xz \
        zstd \
        git \
        git-lfs \
        openssh \
        openssh-client \
        coreutils \
        grep \
        sed \
        findutils \
        diffutils \
        gawk \
        time \
        util-linux \
        procps \
        which \
        tzdata \
        build-base \
        cmake \
        pkgconf \
        make \
        gperf \
        meson \
        ccache \
        nodejs \
        npm \
        typescript \
        go \
        rust \
        cargo \
        rust-clippy \
        rustfmt \
        rust-analyzer \
        python3 \
        py3-pip \
        python3-dev \
        zig \
        zls \
        lua-language-server \
        gopls \
        docker-cli \
        docker-cli-buildx \
        docker-cli-compose \
        ansible \
        ansible-lint \
        ripgrep \
        jq \
        fd \
        sqlite \
        fzf \
        github-cli \
        shellcheck \
        ruff \
        libstdc++ && \
    CLANG_VER=$(clang --version | sed -n 's/.*clang version \([0-9]\{1,2\}\).*/\1/p') && \
    apk add --no-cache "clang${CLANG_VER}-extra-tools" "clang${CLANG_VER}-dev" "lld${CLANG_VER}" && \
    git config --system --add safe.directory '*' && \
    git config --system user.name 'OpenCode Dev' && \
    git config --system user.email 'opencode-dev@localhost' && \
    curl -fsSL -o /usr/local/bin/hadolint \
        https://github.com/hadolint/hadolint/releases/download/v2.15.1/hadolint-Linux-x86_64 && \
    chmod 0755 /usr/local/bin/hadolint

RUN npm install -g \
        opencode-ai \
        pyright \
        typescript-language-server \
        bash-language-server \
        @ansible/ansible-language-server \
        @tailwindcss/language-server \
        emmet-ls \
        vscode-langservers-extracted \
        @biomejs/biome \
        dockerfile-language-server-nodejs

RUN adduser -D -u 1000 -h /home/opencode-dev opencode-dev && \
    mkdir -p /home/opencode-dev/.local/share/opencode \
             /home/opencode-dev/.config/opencode \
             /home/opencode-dev/.cache/opencode

RUN chown -R opencode-dev:opencode-dev /home/opencode-dev

USER opencode-dev
WORKDIR /home/opencode-dev

CMD ["opencode"]
