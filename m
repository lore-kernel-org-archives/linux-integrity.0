Return-Path: <SRS0=Yr3x=37=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0591C35242
	for <linux-integrity@archiver.kernel.org>; Tue, 11 Feb 2020 20:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9805A20708
	for <linux-integrity@archiver.kernel.org>; Tue, 11 Feb 2020 20:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbgBKULJ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 11 Feb 2020 15:11:09 -0500
Received: from smtprelay0225.hostedemail.com ([216.40.44.225]:54742 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728040AbgBKULJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Feb 2020 15:11:09 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id E4814182CED28;
        Tue, 11 Feb 2020 20:11:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bear20_7e20de9071d12
X-Filterd-Recvd-Size: 2810
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue, 11 Feb 2020 20:11:06 +0000 (UTC)
Message-ID: <5c6098c369de85abc5273fdda5da4e1dc5228dc9.camel@perches.com>
Subject: Re: [PATCH v2 2/3] IMA: Add log statements for failure conditions.
From:   Joe Perches <joe@perches.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        zohar@linux.ibm.com, skhan@linuxfoundation.org,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 11 Feb 2020 12:09:50 -0800
In-Reply-To: <ca5e6f88-6946-92ae-d4ac-0f07df54876a@linux.microsoft.com>
References: <20200211024755.5579-1-tusharsu@linux.microsoft.com>
         <20200211024755.5579-2-tusharsu@linux.microsoft.com>
         <9ed05e364f7eb7ccdeed7c580b3aded8fd8697f7.camel@perches.com>
         <ca5e6f88-6946-92ae-d4ac-0f07df54876a@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-02-11 at 11:14 -0800, Tushar Sugandhi wrote:
> Hi Joe,

Rehi Tushar.

> On 2020-02-10 7:23 p.m., Joe Perches wrote:
> > On Mon, 2020-02-10 at 18:47 -0800, Tushar Sugandhi wrote:
> > > process_buffer_measurement() and ima_alloc_key_entry()
> > > functions do not have log messages for failure conditions.
[]
> > > diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
> > []
> > > @@ -90,6 +90,7 @@ static struct ima_key_entry *ima_alloc_key_entry(struct key *keyring,
> > >   
> > >   out:
> > >   	if (rc) {
> > > +		pr_err("Key entry allocation failed, result: %d\n", rc);
> > >   		ima_free_key_entry(entry);
> > >   		entry = NULL;
> > >   	}
> > 
> > Likely the pr_err is unnecessary here as kmalloc, kstrdup
> > and kmemdup all emit a dump_stack() on allocation failure.
> Thanks for pointing out kmalloc, kstrdup, and kmemdup emit a 
> dump_stack(). But keeping the above pr_err() will help associate the 
> failure with IMA.
> For instance - "dmesg | grep ima:" will include this error.
> Perhaps I should add __func__ here as well.
> And since we are redefining the pr_fmt to prefix module and base names, 
> it will help further to pinpoint where exactly the failure is coming from.

The dump_stack is preferred over a single printk message
and the association isn't particularly useful.

> Thanks again. This recommended change certainly makes the code more 
> readable. But again, I am not sure if this patchset is the right one for 
> this proposed change.
> Perhaps I can create another patchset for the above two recommended 
> changes, and only focus on improving logging in this patchset?

Your choice.


