Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:45464 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753433AbeARFxY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jan 2018 00:53:24 -0500
Date: Wed, 17 Jan 2018 22:36:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org
Subject: Re: [PATCH] ima/policy: fix parsing of fsuuid
Message-ID: <20180117213611.GA23599@kroah.com>
References: <1516213631-8974-1-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1516213631-8974-1-git-send-email-rppt@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Jan 17, 2018 at 08:27:11PM +0200, Mike Rapoport wrote:
> The switch to uuid_t invereted the logic of verfication that &entry->fsuuid
> is zero during parsing of "fsuuid=" rule. Instead of making sure the
> &entry->fsuuid field is not attempted to be overwriten, we bail out for
> perfectly correct rule.
> 
> Fixes: 787d8c530af7 ("ima/policy: switch to use uuid_t")
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> ---
>  security/integrity/ima/ima_policy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
