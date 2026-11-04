FROM alpine:latest

RUN apk add --no-cache \
    bash \
    curl \
    git \
    build-base \
    nodejs \
    npm \
    go \
    rust \
    cargo \
    clang \
    lua-language-server \
    gopls \
    rust-analyzer \
    zig \
    docker-cli \
    docker-cli-compose \
    ansible \
    ansible-lint \
    ripgrep \
    jq \
    fd \
    sqlite \
    openssh \
    cmake \
    pkgconf \
    py3-pip \
    python3-dev \
    fzf \
    github-cli \
    libstdc++

RUN npm install -g \
    pyright \
    typescript \
    typescript-language-server \
    bash-language-server \
    @ansible/ansible-language-server \
    opencode-ai \
    @tailwindcss/language-server \
    emmet-ls \
    vscode-langservers-extracted \
    @biomejs/biome
    
RUN adduser -D -u 1000 -h /home/opencode-dev opencode-dev

RUN mkdir -p /home/opencode-dev/.config/opencode && \
    chown -R opencode-dev:opencode-dev /home/opencode-dev

#RUN echo '{ \
#  "$schema": "https://opencode.ai/config.json", \
#  "model": "strata/local-model", \
#  "lsp": true, \
#  "provider": { \
#    "strata": { \
#      "npm": "@ai-sdk/openai-compatible", \
#      "name": "Strata Engine", \
#      "limit": { \
#        "context": 65536, \
#        "output": 8192 \
#      }, \
#      "options": { \
#        "baseURL": "http://172.17.0.1:8080/v1", \
#        "apiKey": "sk-strata-yhlgrrWsqXKw5BZnZH50hR2ZSWipOlaE" \
#      }, \
#      "models": { \
#        "local-model": { \
#          "name": "local-model" \
#        } \
#      } \
#    } \
#  } \
#}' > /home/opencode-dev/.config/opencode/opencode.jsonc

USER opencode-dev
WORKDIR /home/opencode-dev

CMD ["opencode"]
