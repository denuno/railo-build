%global railodir %{_libexecdir}/railo/${railo.build.version.major}
%global serverdir %{railodir}/railo-server/
%global patchesdir %{railodir}/railo-server/patches
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
%define name      Railo Core
%define summary   Railo Core Library
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
Requires:  filesystem, bash, grep, java-1.6.0-openjdk, railo-libs-${railo.build.version.major}
Provides:  %{name}
URL:       %{url}
Buildroot: %{buildroot}
%description
This tool kicks ass and chews bubble-gum, and it's all outta gum.  Use it to create distros of stuff, and distro stuff.
%prep
%setup -q
%build
%pre
rm -rf %{buildroot}%{_prefix}
if [ -e /home/${rpm.user} ]; then
  echo "${rpm.user} user exists, thus not trying to add again" >&2
else
	mkdir -p /home/${rpm.user}
	useradd -d /home/${rpm.user} ${rpm.user}
fi
%install
install -d %{buildroot}%{patchesdir}
tar cf - . | (cd %{buildroot}%{patchesdir}; tar xfp -)
rm -f  %{railodir}/railo-server
ln -s  %{railodir}/railo-server %{buildroot}%{serverdir}

%post
echo "--------------------------------------------------------"
echo "   %{name} installed in %{patchesdir}"
echo "--------------------------------------------------------"
${rpm.post}
%clean
rm -rf %{buildroot}%{patchesdir}
%postun
rm -rf %{patchesdir}/${distro.name}
%files
%defattr(-,${rpm.user},root)
%{patchesdir}/*
# make executable
#%attr(755,${rpm.user},root)%{patchesdir}/../${distro.name}.sh
#%attr(755,${rpm.user},root)%{patchesdir}/${distro.name}.sh