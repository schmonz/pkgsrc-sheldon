# $NetBSD: Makefile,v 1.11 2024/11/14 22:21:36 wiz Exp $

DISTNAME=		sheldon-0.8.0
PKGREVISION=		3
CATEGORIES=		shells
MASTER_SITES=		${MASTER_SITE_GITHUB:=rossmacarthur/}
GITHUB_TAG=		${PKGVERSION_NOREV}

MAINTAINER=		schmonz@NetBSD.org
HOMEPAGE=		https://github.com/rossmacarthur/sheldon/
COMMENT=		Fast, configurable shell plugin manager
LICENSE=		apache-2.0

.include "cargo-depends.mk"

USE_LANGUAGES=		c
USE_TOOLS+=		pkg-config

AUTO_MKDIRS=		yes

RUSTFLAGS+=		-C link-arg=${COMPILER_RPATH_FLAG}${SSLBASE}/lib
RUSTFLAGS+=		-C link-arg=${COMPILER_RPATH_FLAG}${PREFIX}/lib

do-install:
	${INSTALL_DATA} ${WRKSRC}/README.md \
		${DESTDIR}${PREFIX}/share/doc/${PKGBASE}/
	${INSTALL_DATA} ${WRKSRC}/completions/${PKGBASE}.bash \
		${DESTDIR}${PREFIX}/share/bash-completion/completions/${PKGBASE}
	${INSTALL_DATA} ${WRKSRC}/completions/${PKGBASE}.zsh \
		${DESTDIR}${PREFIX}/share/zsh/site-functions/_${PKGBASE}
	${INSTALL_PROGRAM} ${WRKSRC}/target/release/${PKGBASE} ${DESTDIR}${PREFIX}/bin/

.include "../../lang/rust/cargo.mk"
.include "../../converters/libiconv/buildlink3.mk"
.include "../../devel/zlib/buildlink3.mk"
.include "../../security/openssl/buildlink3.mk"
.include "../../www/curl/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
