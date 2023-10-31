Name:           lightly
Version:        0.{{{ git_dir_version lead=4 follow=1 }}}
Release:        1%{?dist}
Summary:        A modern style for qt applications (boehs fork)

License:        GPLv2
URL:            https://github.com/boehs/Lightly
Source:         %{url}/archive/refs/heads/master.zip

BuildRequires:  gcc-c++
BuildRequires:  cmake
BuildRequires:  extra-cmake-modules
BuildRequires:  cmake(Qt5Core)
BuildRequires:  cmake(Qt5Gui)
BuildRequires:  cmake(Qt5DBus)
BuildRequires:  cmake(Qt5X11Extras)
BuildRequires:  cmake(KF5GuiAddons)
BuildRequires:  cmake(KF5WindowSystem)
BuildRequires:  cmake(KF5I18n)
BuildRequires:  cmake(KDecoration2)
BuildRequires:  cmake(KF5CoreAddons)
BuildRequires:  cmake(KF5ConfigWidgets)
BuildRequires:  cmake(Qt5UiTools)
BuildRequires:  cmake(KF5GlobalAccel)
BuildRequires:  cmake(KF5IconThemes)
BuildRequires:  kwin-devel
BuildRequires:  libepoxy-devel
BuildRequires:  cmake(KF5Init)
BuildRequires:  cmake(KF5Crash)
BuildRequires:  cmake(KF5KIO)
BuildRequires:  cmake(KF5Notifications)
BuildRequires:  kf5-kpackage-devel
BuildRequires:  kf5-frameworkintegration-devel

%description
Lightly is a fork of breeze theme style that aims to be visually modern and
minimalistic.

%prep
%autosetup -n Lightly-master

%build
%cmake
%cmake_build

%install
%cmake_install

%files
%license COPYING
%doc AUTHORS README.md
%{_libdir}/cmake/Lightly/
%{_libdir}/kconf_update_bin/kde4lightly
%{_libdir}/liblightlycommon5.so.*
%{_qt5_plugindir}/kstyle_lightly_config.so
%{_qt5_plugindir}/org.kde.kdecoration2/lightlydecoration.so
%{_qt5_plugindir}/styles/lightly.so
%dir %{_datadir}/color-schemes
%{_datadir}/color-schemes/Lightly.colors
%{_datadir}/kconf_update/kde4lightly.upd
%{_datadir}/kservices5/lightlydecorationconfig.desktop
%{_datadir}/kservices5/lightlystyleconfig.desktop
%{_datadir}/kstyle/themes/lightly.themerc

%changelog
%autochangelog