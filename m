Return-Path: <SRS0=GWgT=SG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1084C4360F
	for <linux-integrity@archiver.kernel.org>; Thu,  4 Apr 2019 18:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CE4206B7
	for <linux-integrity@archiver.kernel.org>; Thu,  4 Apr 2019 18:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfDDSTF (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:19:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:40640 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727310AbfDDSTF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Apr 2019 14:19:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3716FAFB4;
        Thu,  4 Apr 2019 18:19:04 +0000 (UTC)
Date:   Thu, 4 Apr 2019 20:19:02 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     ltp@lists.linux.it, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Ignaz Forster <iforster@suse.de>, Fabian Vogt <FVogt@suse.com>,
        Weihua Du <WHDu@suse.com>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 3/3] ima: Add overlay test
Message-ID: <20190404181901.GA22718@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190327161638.7407-1-pvorel@suse.cz>
 <20190327161638.7407-4-pvorel@suse.cz>
 <1553856587.9420.44.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1553856587.9420.44.camel@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

thanks for your comments!

> > +	grep -q ima_appraise_tcb /proc/cmdline || \
> > +		tst_brk TCONF "Test requires ima_appraise_tcb kernel parameter"

> Instead of specifying individual policies separately, the newer method
> of specifying builtin IMA policies on the boot command line is
> "ima_policy=", with a list of policies.  The builtin appraise policy
> would be specified as "ima_policy=appraise_tcb".  Refer to
> Documentation/admin-guide/kernel-parameters.txt for the list of
> builtin policies.
I guess grep for any policy (ima_policy=) or ima_appraise_tcb shold e enough.
Am I right?

BTW I guess ima_appraise_tcb should be deprecated in kernel-parameters.txt.

> > +}
> > +
> > +do_test()
> > +{
> > +	local file="foo.txt"
> > +	local f
> > +
> > +	tst_mount
> > +	mounted=1
> > +
> > +	ROD echo lower \> $lower/$file

> For some reason "mntpoint/lower" isn't loopback mounted.  With the
> builtin appraise policy, because it is a tmpfs filesystem,
> security.ima does not exist.  Writing to the merged directory then
> fails.

> + df -T mntpoint/lower
> Filesystem     Type  1K-blocks   Used Available Use% Mounted on
> tmpfs          tmpfs   4020348 262316   3758032   7% /tmp
My bad, I forged to add TST_NEEDS_DEVICE=1 to ima_overlay.sh (I'll add it into
v2). That was the missing piece to enable loop device (in the end of ima_setup.sh)


> + getfattr -m '^security' --dump mntpoint/lower/foo.txt
> # file: mntpoint/lower/foo.txt
> security.evm=0sAq8niNi4X7cYntKSAki1Woc+Y5Yq
> security.selinux="unconfined_u:object_r:user_tmp_t:s0"

> Mimi


Kind regards,
Petr
