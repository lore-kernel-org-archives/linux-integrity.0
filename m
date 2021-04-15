Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B379C433ED
	for <linux-integrity@archiver.kernel.org>; Thu, 15 Apr 2021 16:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C79861184
	for <linux-integrity@archiver.kernel.org>; Thu, 15 Apr 2021 16:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhDOQ2b (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 15 Apr 2021 12:28:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:33684 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232759AbhDOQ2b (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Apr 2021 12:28:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8FD91B2E1;
        Thu, 15 Apr 2021 16:28:07 +0000 (UTC)
Date:   Thu, 15 Apr 2021 18:28:06 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/2] travis: Fix openSUSE Tumbleweed
Message-ID: <YHhplvJDF56YHj/U@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210415112728.9307-1-pvorel@suse.cz>
 <31a1d0cbc858c14b51ee33b6861fb36d3ffbde4d.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31a1d0cbc858c14b51ee33b6861fb36d3ffbde4d.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

...
> > Changes v2->v3:
> > * remove sudo (replaced by --no-same-owner)

> Thanks, Petr.  Other than actually removing the "sudo",  the patch
> looks good and works properly on our internal travis too.  Assuming you
> don't object, I'll remove the "sudo".
Yes, and sorry for leaving it there.

Kind regards,
Petr
