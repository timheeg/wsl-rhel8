ARG BASE_IMAGE_NAME
ARG BASE_IMAGE_TAG
FROM $BASE_IMAGE_NAME:$BASE_IMAGE_TAG

RUN --mount=type=secret,id=RHEL8_ORG \
  --mount=type=secret,id=RHEL8_ACTIVATION_KEY \
  subscription-manager register \
  --org=$(cat /run/secrets/RHEL8_ORG) \
  --activationkey=$(cat /run/secrets/RHEL8_ACTIVATION_KEY)

# Install tools
#
# iputils for ping
# sudo for non-root user sudo support
# vim-enhanced for color vi support in git
# wget to install vscode server
#
RUN dnf update -y \
  && dnf -y install \
  git \
  iputils \
  sudo \
  vim-enhanced \
  wget \
  && dnf clean all \
  && rm -rf /var/cache/yum

# Install root user .bashrc
COPY .bashrc /root/

# 🛂 Create the non-root (developer) user
ARG USERNAME
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
#
# Note, most of our usernames use the `first.last` template. Having a `.` in a
# username is POSIX compliant (good). However, `sudoers.d` ignores any file
# containing a `.` as a way to disable changes; so files named `first.last` are
# simply ignored. Instead, use the `USER_UID` as the file name.
# See https://superuser.com/a/869145
#
RUN groupadd --gid $USER_GID $USERNAME \
  && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
  && echo $USERNAME ALL=\(ALL\) NOPASSWD: ALL > /etc/sudoers.d/$USER_UID \
  && chmod 0440 /etc/sudoers.d/$USER_UID

# Specify as the default user in the WSL config
RUN printf "\n[user]\ndefault = $USERNAME\n" >> /etc/wsl.conf

# 🔀 Configure system git configuration
COPY git-config.sh /tmp/.
RUN /tmp/git-config.sh && rm /tmp/git-config.sh

# 🔀 Setup user-specific git configuration
#
# Copy the temp generated user config to the "global" user home with the script
#
COPY .gitconfig /home/$USERNAME
RUN chown $USER_UID:$USER_GID /home/$USERNAME/.gitconfig

COPY git-config-user.sh /tmp/.
RUN chown $USER_UID:$USER_GID /tmp/git-config-user.sh \
  && chmod +x /tmp/git-config-user.sh

# Install the .bashrc for the user
COPY .bashrc /home/$USERNAME
RUN chown $USER_UID:$USER_GID "/home/$USERNAME/.bashrc" \
  && chmod 644 "/home/$USERNAME/.bashrc"

# 🧑‍💻 Change to non-root user
USER $USERNAME

# Execute global git config settings.
RUN /tmp/git-config-user.sh

CMD [ "bash" ]
