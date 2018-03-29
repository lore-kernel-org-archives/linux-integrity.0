Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44006 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbeC2GST (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Mar 2018 02:18:19 -0400
Date: Thu, 29 Mar 2018 08:18:16 +0200
From: Petr Vorel <pvorel@suse.cz>
To: George Wilson <gcwilson@us.ibm.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [RFC PATCH v2 3/4] ima/ima_boot_aggregate: Increase
 MAX_EVENT_SIZE to 8k
Message-ID: <20180329061816.GB31604@x230>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20180314155731.5943-1-pvorel@suse.cz>
 <20180314155731.5943-4-pvorel@suse.cz>
 <1522179855.3541.191.camel@linux.vnet.ibm.com>
 <OF557260E5.C2BA817A-ON8625825D.007ABFC1-8625825D.007AFB67@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <OF557260E5.C2BA817A-ON8625825D.007ABFC1-8625825D.007AFB67@notes.na.collabserv.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi George,

> > Is there a way of making this value system dependent?  On my
> > laptop this is fine, but for PowerVM w/TPM 1.2 I've been told this is
> > too small.

> Why not follow the spec?  PowerVM has enormous events because they
> were allowed by the 1.2 spec.  The 2.0 spec recommends 1M so I think
> they should be at least 1M.  Because they're large, they should really
> be dynamically allocated.
Make sense. Lets try 1M.
Thanks a lot for your input.


Kind regards,
Petr
