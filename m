Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750913AbeEGMBY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 May 2018 08:01:24 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w47BxTvl021455
        for <linux-integrity@vger.kernel.org>; Mon, 7 May 2018 08:01:23 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2htm69njy9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 07 May 2018 08:01:22 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 7 May 2018 13:01:20 +0100
Subject: Re: [PATCH ima-evm-utils] autotools: Try to find correct manpage
 stylesheet path
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Date: Mon, 07 May 2018 08:01:17 -0400
In-Reply-To: <20180326080436.18188-1-pvorel@suse.cz>
References: <20180326080436.18188-1-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1525694477.3539.230.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Petr,

On Mon, 2018-03-26 at 10:04 +0200, Petr Vorel wrote:
> xslt docbook styles differ across distributions, which requires some
> workarounds [1]. Try to check the manpage stylesheet path with
> xmlcatalog and fallback to the original one.
> 
> Add option --with-xml-catalog to use non-default catalog.
> 
> + remove trailing whitespace
> 
> [1] https://github.com/CESNET/ipfixcol/blob/master/base/m4/lbr_check_xsltproc.m4
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Thanks!  This patch is now in master.

Mimi
> ---
> NOTE: resent to inux-integrity ML as ML on sourceforge seems to be left.
> ---
>  Makefile.am               |  3 ---
>  configure.ac              |  6 ++++--
>  m4/manpage-docbook-xsl.m4 | 28 ++++++++++++++++++++++++++++
>  3 files changed, 32 insertions(+), 5 deletions(-)
>  create mode 100644 m4/manpage-docbook-xsl.m4
> 
> diff --git a/Makefile.am b/Makefile.am
> index 06ebf59..dba408d 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -23,9 +23,6 @@ rpm: $(tarname)
>  	cp $(tarname) $(SRCS)/
>  	rpmbuild -ba --nodeps $(SPEC)
> 
> -# requires asciidoc, xslproc, docbook-xsl
> -MANPAGE_DOCBOOK_XSL = /usr/share/xml/docbook/stylesheet/docbook-xsl/manpages/docbook.xsl
> -
>  evmctl.1.html: README
>  	@asciidoc -o $@ $<
> 
> diff --git a/configure.ac b/configure.ac
> index 6822f39..0497eb7 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -5,7 +5,7 @@ AC_INIT(ima-evm-utils, 1.1, zohar@linux.vnet.ibm.com)
>  AM_INIT_AUTOMAKE
>  AC_CONFIG_HEADERS([config.h])
>  AC_CONFIG_MACRO_DIR([m4])
> - 
> +
>  AC_CANONICAL_HOST
> 
>  # Checks for programs.
> @@ -41,6 +41,8 @@ else
>  	CFLAGS="$CFLAGS -Wall -Wstrict-prototypes -pipe -fomit-frame-pointer"
>  fi
> 
> +EVMCTL_MANPAGE_DOCBOOK_XSL
> +
>  # for gcov
>  #CFLAGS="$CFLAGS -Wall -fprofile-arcs -ftest-coverage"
>  #CXXFLAGS="$CXXFLAGS -Wall -fprofile-arcs -ftest-coverage"
> @@ -56,7 +58,7 @@ AC_OUTPUT
>  # Give some feedback
>  echo
>  echo
> -echo	"Configuration:"		
> +echo	"Configuration:"
>  echo	"	debug:	$pkg_cv_enable_debug"
>  echo
> 
> diff --git a/m4/manpage-docbook-xsl.m4 b/m4/manpage-docbook-xsl.m4
> new file mode 100644
> index 0000000..24ae55a
> --- /dev/null
> +++ b/m4/manpage-docbook-xsl.m4
> @@ -0,0 +1,28 @@
> +dnl Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
> +dnl Find docbook manpage stylesheet
> +
> +AC_DEFUN([EVMCTL_MANPAGE_DOCBOOK_XSL], [
> +	AC_PATH_PROGS(XMLCATALOG, xmlcatalog)
> +	AC_ARG_WITH([xml-catalog],
> +		AC_HELP_STRING([--with-xml-catalog=CATALOG],
> +				[path to xml catalog to use]),,
> +				[with_xml_catalog=/etc/xml/catalog])
> +	XML_CATALOG_FILE="$with_xml_catalog"
> +	AC_SUBST([XML_CATALOG_FILE])
> +	AC_MSG_CHECKING([for XML catalog ($XML_CATALOG_FILE)])
> +	if test -f "$XML_CATALOG_FILE"; then
> +		have_xmlcatalog_file=yes
> +		AC_MSG_RESULT([found])
> +	else
> +		AC_MSG_RESULT([not found])
> +	fi
> +	if test "x${XMLCATALOG}" != "x" -a "x$have_xmlcatalog_file" = "xyes"; then
> +		DOCBOOK_XSL_URI="http://docbook.sourceforge.net/release/xsl/current"
> +		DOCBOOK_XSL_PATH="manpages/docbook.xsl"
> +		MANPAGE_DOCBOOK_XSL=$(${XMLCATALOG} ${XML_CATALOG_FILE} ${DOCBOOK_XSL_URI}/${DOCBOOK_XSL_PATH} | sed -n 's|^file:/\+|/|p;q')
> +	fi
> +	if test "x${MANPAGE_DOCBOOK_XSL}" = "x"; then
> +		MANPAGE_DOCBOOK_XSL="/usr/share/xml/docbook/stylesheet/docbook-xsl/manpages/docbook.xsl"
> +	fi
> +	AC_SUBST(MANPAGE_DOCBOOK_XSL)
> +])
