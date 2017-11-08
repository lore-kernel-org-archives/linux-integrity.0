Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:49525 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752680AbdKHWYg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Nov 2017 17:24:36 -0500
Received: by mail-io0-f174.google.com with SMTP id n137so7686757iod.6
        for <linux-integrity@vger.kernel.org>; Wed, 08 Nov 2017 14:24:36 -0800 (PST)
Date: Wed, 8 Nov 2017 15:24:34 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Peter Huewe <peterhuewe@gmx.de>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: Update MAINTAINERS for Jason Gunthorpe
Message-ID: <20171108222434.GF7063@ziepe.ca>
References: <20171031202357.GA1030@ziepe.ca>
 <20171103142841.2nphkjojzamrdezm@linux.intel.com>
 <0812DDC3-187D-4F29-BFB5-9A4F509CA376@gmx.de>
 <20171107150356.uln3lks64zt5oxjv@linux.intel.com>
 <20171108063640.kxwag6fzguetpjnf@linux.intel.com>
 <E803B459-CB11-4E23-B3BC-4DEF2A0C40B6@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E803B459-CB11-4E23-B3BC-4DEF2A0C40B6@gmx.de>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Nov 08, 2017 at 10:27:37AM +0100, Peter Huewe wrote:

> >Updating that file goes out of my territory other than acking the
> >updates. 

> Imho not really, since there is no MAINTAINERS maintainer.  If you
> feel uncomfortable with adding the changes to MAINTAINERS via your
> tree, please ask James to pull them up - just as Mimi did for her
> linux-integrity update.

Agreed, if you are submitting pull requests then the MAINTAINERS
update for TPM related things should go into your pull request. That
is appropriate..

It isn't necessary for everything to be cc'd everywhere, ultimately it
is your responsibility as the TPM maintainer to accept/reject this
change.

If it was a larger change, like adding/removing a maintainer then a
large audiance would be appropriate, but this is just changing
spelling and the patch was PGP signed ..

Jason
