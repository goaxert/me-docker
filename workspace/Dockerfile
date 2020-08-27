FROM ubuntu:18.04

RUN apt-get update

# sshd
RUN apt-get update && apt-get install -y openssh-server

RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
# RUN sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN sed -i 's/.*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i "s/.*PasswordAuthentication.*/PasswordAuthentication yes/g" /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22

# oh-my-zsh
RUN apt-get install -y zsh git

RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

RUN apt-get install -y autojump

RUN git clone https://github.com/denysdovhan/spaceship-prompt.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt
RUN ln -s ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt/spaceship.zsh-theme ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship.zsh-theme
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

RUN chsh -s /bin/zsh

RUN sed -i 's/robbyrussell/spaceship/g' /root/.zshrc
RUN sed -i 's/git/git autojump zsh-autosuggestions zsh-syntax-highlighting/g' /root/.zshrc

# other packages
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y \
    tmux \
    vim \
    make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    llvm \
    libncurses5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev

# docker
RUN apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
RUN apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io

# pyenv
RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv
RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> /root/.zshrc
RUN echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> /root/.zshrc
RUN /root/.pyenv/bin/pyenv install 3.6.10
RUN curl https://bootstrap.pypa.io/get-pip.py | python3

# tmux
RUN cd ~ && \
    git clone https://github.com/gpakosz/.tmux.git && \
    ln -s -f .tmux/.tmux.conf && \
    cp .tmux/.tmux.conf.local .

RUN sed -i 's/#tmux_conf_theme_/tmux_conf_theme_/g' ~/.tmux.conf.local
RUN pip install --user tmuxp
RUN echo 'export PATH="/root/.local/bin:$PATH"' >> /root/.zshrc

# clean
RUN rm -rf /var/lib/apt/lists/*

ENV TERM=xterm-256color
WORKDIR /root
RUN sed -i 's/source $ZSH\/oh-my-zsh.sh/HISTFILE=$HOME\/.zsh_history.d\/.zsh_history\nsource $ZSH\/oh-my-zsh.sh/g' ~/.zshrc

CMD ["/usr/sbin/sshd", "-D"]
