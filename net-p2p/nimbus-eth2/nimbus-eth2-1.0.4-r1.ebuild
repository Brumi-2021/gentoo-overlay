# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Nim implementation of the Ethereum 2.0 blockchain"
HOMEPAGE="https://github.com/status-im/nimbus-eth2"
EGIT_REPO_URI="https://github.com/status-im/nimbus-eth2.git"
EGIT_COMMIT="v${PV/_/-}"
RESTRICT="strip"

LICENSE="MIT-with-advertising Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="lto"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	NIMFLAGS="-d:insecure -d:disableMarchNative --passC:'${CFLAGS}' --passL:'${LDFLAGS}' --parallelBuild:1 -d:chronicles_sinks=textlines -d:chronicles_colors=none"
	if ! use lto; then
		NIMFLAGS="$NIMFLAGS -d:disableLTO"
	fi
	emake \
		LOG_LEVEL="TRACE" \
		NIMFLAGS="${NIMFLAGS}" \
		QUICK_AND_DIRTY_COMPILER=1 \
		nimbus_beacon_node \
		nimbus_signing_process
}

src_install() {
	dobin build/nimbus_beacon_node
	dobin build/nimbus_signing_process

	newconfd "${FILESDIR}/${PN}.conf" ${PN}
	newinitd "${FILESDIR}/${PN}.init" ${PN}
	keepdir /var/log/${PN}

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/${PN}.logrotate ${PN}

	dodoc "${FILESDIR}/prometheus.yml.example"
}
