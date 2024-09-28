# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="SoapySDR Airspyhf-SDR Support Module"
HOMEPAGE="https://github.com/pothosware/SoapyAirspyHF"

if [ "${PV}" = "9999" ]; then
	EGIT_REPO_URI="https://github.com/pothosware/SoapyAirspyHF.git"
	inherit git-r3
else
	KEYWORDS="amd64 ~arm ~riscv ~x86"
	SRC_URI="https://github.com/pothosware/SoapyAirspyHF/archive/soapy-airspyhf-${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/SoapyAirspyHF-soapy-airspyhf-"${PV}"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="net-wireless/soapysdr:=
		net-wireless/airspyhf:="
DEPEND="${RDEPEND}"
BDEPEND=""
