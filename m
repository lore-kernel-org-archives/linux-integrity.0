Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03E3C433DB
	for <linux-integrity@archiver.kernel.org>; Tue, 23 Feb 2021 22:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8621764E79
	for <linux-integrity@archiver.kernel.org>; Tue, 23 Feb 2021 22:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhBWWmA (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 23 Feb 2021 17:42:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:47744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233533AbhBWWjf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Feb 2021 17:39:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 22E00ACE5;
        Tue, 23 Feb 2021 22:38:53 +0000 (UTC)
Date:   Tue, 23 Feb 2021 23:38:51 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, nramas@linux.microsoft.com,
        linux-integrity@vger.kernel.org, dm-devel@redhat.com,
        ltp@lists.linux.it
Subject: Re: [PATCH v2 1/2] IMA: generalize key measurement tests
Message-ID: <YDWD+9dB8kx0ZPYR@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200928035605.22701-1-tusharsu@linux.microsoft.com>
 <20200928035605.22701-2-tusharsu@linux.microsoft.com>
 <20201221230531.GD4453@pevik>
 <28c14c80-660a-0f36-64ca-ae5230992032@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28c14c80-660a-0f36-64ca-ae5230992032@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

> Thanks for your review.
> My sincere apologies for missing this email and not responding in time.

> The device mapper measurement work is being revisited - to cover aspects
> like more DM targets (not just dm-crypt), better memory management,
> more relevant attributes from the DM targets, other corner cases etc.

> Therefore, even though this patch, "1/2: generalize key measurement
> tests", would be useful for other tests; I will have to revisit the
> second patch, "2/2: dm-crypt measurements", to address the DM side changes I
> mentioned above.

> I will revisit this series, esp. testing the DM target measurements
> part, once the kernel work I mentioned above is close to completion.

> I will also address your feedback on patch #1 and #2 from v2 iteration
> at that time.

> Thanks again for your review and feedback.

I updated your patchset a bit and going to send it to ML.

Kind regards,
Petr

> Thanks,
> Tushar
