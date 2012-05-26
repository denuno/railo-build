%global railodir %{_libexecdir}/railo/${railo.build.version.major}
%global libsdir %{railodir}/libs
#===============================================================================
# Name: railo.spec 
#-------------------------------------------------------------------------------
# $Id: railo.spec,v 1.1 $
#-------------------------------------------------------------------------------
# Purpose: RPM Spec file for railo
# Version 3.33
#===============================================================================
# No debuginfo:
%define debug_package %{nil}
# %define _target   noarch
%define _target_os  Linux
%define name      ${distro.name}
%define summary   Railo Libraries
%define version   ${distro.version}
%define release   Base
%define license   LGPL
%define group     Applications/System
%define _topdir  %(echo $PWD)
%define _tmppath  /tmp
%define source    release.tar.gz
%define url       http://getrailo.org
%define vendor    Railo Technologies
%define packager  Railo
%define _Rsourcedir  %{_topdir}/SOURCES
%define buildroot %{_tmppath}/%{name}-root
# %define exclude /home/cfml
Name:      %{name}
Summary:   %{summary}
Version:   %{version}
Release:   %{release}
License:   %{license}
Group:     %{group}
Source0:   %{source}
BuildArch: noarch
Requires:  filesystem, java-1.6.0-openjdk
Provides:  %{name}
URL:       %{url}
Buildroot: %{buildroot}
%description
This tool kicks ass and chews bubble-gum, and it's all outta gum.  Use it to create distros of stuff, and distro stuff.
%prep
%setup -q
%build
%pre
rm -rf %{buildroot}%{libsdir}
if [ -e /home/${rpm.user} ]; then
  echo "${rpm.user} user exists, thus not trying to add again" >&2
else
	mkdir -p /home/${rpm.user}
	useradd -d /home/${rpm.user} ${rpm.user}
fi
%install
install -d %{buildroot}%{libsdir}
tar cf - . | (cd %{buildroot}%{libsdir}; tar xfp -)
rm -f  %{railodir}/libs
ln -s  %{railodir}/libs %{buildroot}%{libsdir}
%post
echo "--------------------------------------------------------"
echo "   %{name} installed in %{libsdir}"
echo "--------------------------------------------------------"
${rpm.post}
%clean
rm -rf %{buildroot}%{libsdir}
%postun
rm -rf %{libsdir}
%files
%defattr(-,${rpm.user},root)
%{libsdir}/*