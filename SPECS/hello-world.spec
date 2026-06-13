Name:       hello-world
Version:    1
Release:    2%{?dist}
Summary:    Most simple RPM package
License:    GPLv3
URL:        https://example.com/hello-world 
BuildArch:  noarch

Source0:    %{name}-%{version}.tar.gz

# systemd macros for proper service integration
%{?systemd_requires}
BuildRequires:  systemd-rpm-macros
Requires(post): systemd
Requires(preun): systemd

%description
This is my first RPM package, which does nothing special.

%prep
%setup -q

%install
mkdir -p %{buildroot}/usr/bin/

install -D -m 0755 %{_builddir}/%{name}-%{version}/%{name}.sh %{buildroot}%{_bindir}/%{name}.sh
install -D -m 0644 %{_builddir}/%{name}-%{version}/%{name}.conf %{buildroot}/etc/%{name}/%{name}.conf
install -D -m 0644 %{_builddir}/%{name}-%{version}/%{name}.service %{buildroot}%{_unitdir}/%{name}.service


%post
%systemd_post %{name}.service
# fallback for container
systemctl enable %{name}.service 2>/dev/null || : 
systemctl start %{name}.service 2>/dev/null || :

%preun
%systemd_preun %{name}.service

%files
/usr/bin/%{name}.sh
%config(noreplace) /etc/%{name}/%{name}.conf
%{_unitdir}/%{name}.service

%changelog
* Sat Jun 13 2026 Marcin Cimaszewski <marcin@cimaszewski.eu> - 1-2
- Fixed installation path from /usr/local/bin to /usr/bin
- Added proper License and URL tags
