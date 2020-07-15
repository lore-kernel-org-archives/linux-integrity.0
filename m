Return-Path: <SRS0=nr5y=A2=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB81C433DF
	for <linux-integrity@archiver.kernel.org>; Wed, 15 Jul 2020 06:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6D7E20672
	for <linux-integrity@archiver.kernel.org>; Wed, 15 Jul 2020 06:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgGOGV2 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 15 Jul 2020 02:21:28 -0400
Received: from [195.135.220.15] ([195.135.220.15]:48320 "EHLO mx2.suse.de"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgGOGV2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 02:21:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BC861B634;
        Wed, 15 Jul 2020 06:21:29 +0000 (UTC)
Date:   Wed, 15 Jul 2020 08:21:25 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH ima-evm-utils] Check for tsspcrread in runtime
Message-ID: <20200715062125.GA7493@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200714154659.8080-1-pvorel@suse.cz>
 <1594757196.12900.191.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1594757196.12900.191.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On Tue, 2020-07-14 at 17:46 +0200, Petr Vorel wrote:
> > instead of checking in build time as it's runtime dependency.
> > Also log when tsspcrread not found to make debugging easier.

> > We search for tsspcrread unless there is tss2-esys with Esys_PCR_Read(),
> > thus pcr_none.c was dropped as unneeded.

> > file_exist(), file_exist() and MIN() taken from LTP project.

> One of these "file_exists" I assume is suppose to be "tst_get_path".
Yes. I'm sorry, thanks for catching it.


> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi Mimi,

> > small improvement based on the current next-testing branch
> > (9638068aff2476b567185d7eb94126449ad89ca7).

> > I'm sorry I don't have the required setup, thus didn't test this patch.

> > Kind regards,
> > Petr

> Nice!  It works.
Thanks a lot for a testing?

> > diff --git a/src/pcr_tsspcrread.c b/src/pcr_tsspcrread.c
> > @@ -47,8 +48,21 @@

> >  #include "utils.h"

> > -int tpm2_pcr_supported(void)
> > +#define CMD "tsspcrread"
> > +
> > +static char path[PATH_MAX];
> > +
> > +int tpm2_pcr_supported(char **errmsg)
> >  {
> > +	int ret;
> > +
> > +	if (get_cmd_path(CMD, path, sizeof(path))) {
> > +		ret = asprintf(errmsg, "Couldn't find '%s' in $PATH", CMD);
> > +		if (ret == -1)	/* the contents of errmsg is undefined */
> > +			*errmsg = NULL;
> > +		return 0;
> > +	}
> > +

> Any chance you could also emit the pathname on success as well?

Do you mean to print it into stderr:

int tpm2_pcr_supported(char **errmsg)
{
	int ret;

	if (get_cmd_path(CMD, path, sizeof(path))) {
		ret = asprintf(errmsg, "Couldn't find '%s' in $PATH", CMD);
		if (ret == -1)	/* the contents of errmsg is undefined */
			*errmsg = NULL;
		return 0;
	}

	ret = asprintf(errmsg, "Found '%s' in $PATH", CMD);
	if (ret == -1)	/* the contents of errmsg is undefined */
		*errmsg = NULL;
	return 1;
}

Shell I post v2 or you amend my patch?

BTW I was thinking to create custom function / macro for handling errmsg to
reduce duplicity.

+ there is minor warning on newer gcc, I'm not sure how to fix that:

evmctl.c: In function ‘read_tpm_banks’:
evmctl.c:1404:25: warning: ‘%2.2d’ directive writing between 2 and 10 bytes into a region of size 3 [-Wformat-overflow=]
 1404 |   sprintf(pcr_str, "PCR-%2.2d", i);
      |                         ^~~~~
evmctl.c:1404:20: note: directive argument in the range [0, 2147483647]
 1404 |   sprintf(pcr_str, "PCR-%2.2d", i);
      |                    ^~~~~~~~~~~
evmctl.c:1404:3: note: ‘sprintf’ output between 7 and 15 bytes into a destination of size 7
 1404 |   sprintf(pcr_str, "PCR-%2.2d", i);
      |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Kind regards,
Petr
