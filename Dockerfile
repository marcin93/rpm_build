# Stage: build RPM inside Rocky Linux
FROM rockylinux:9

# Install rpmbuild toolchain
RUN dnf install -y rpm-build systemd-rpm-macros rpmdevtools && dnf clean all

# Set up rpmbuild directory tree
RUN rpmdev-setuptree

# Copy sources
COPY SOURCES/ /root/rpmbuild/SOURCES/
COPY SPECS/   /root/rpmbuild/SPECS/

# Build the RPM
WORKDIR /root/rpmbuild
RUN rpmbuild -bb SPECS/hello-world.spec

# The built RPM lands in /root/rpmbuild/RPMS/noarch/
# Default command: list the built RPM
CMD ["find", "/root/rpmbuild/RPMS", "-name", "*.rpm"]
