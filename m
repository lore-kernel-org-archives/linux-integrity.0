Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:16878 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752070AbdKZOVN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 26 Nov 2017 09:21:13 -0500
Date: Sun, 26 Nov 2017 16:21:09 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: flihp <flihp@twobit.us>, linux-kernel@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        "Tricca, Philip B" <philip.b.tricca@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        "Roberts, William C" <william.c.roberts@intel.com>
Subject: Re: FW: [RFC PATCH] tpm: don't return -EINVAL if TPM command
 validation fails
Message-ID: <20171126142109.rs434iod4gwekrbo@linux.intel.com>
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171120231512.6wpqgcggfta3am7m@linux.intel.com>
 <7c148cf0-2403-55cf-1633-ff326d5c6f7b@redhat.com>
 <20171121123006.esr7yxs5lvorlfjf@linux.intel.com>
 <ebb69b95-96e3-b1cd-a7d0-6792e411e6d4@redhat.com>
 <DB638850A6A2434A93ECADDA0BC838905F09D5D9@ORSMSX103.amr.corp.intel.com>
 <602091d7-1b16-4694-57b2-8031acce8cbc@twobit.us>
 <a6305620-ac5c-5ead-7dd6-ed4e48e75e78@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a6305620-ac5c-5ead-7dd6-ed4e48e75e78@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Nov 22, 2017 at 08:25:29PM +0100, Javier Martinez Canillas wrote:
> That was my interpretation as well and what I was arguing about. I'm glad to
> know that you also think the same.

It could be that this rationale has been your earlier emails but
I just haven't recognized it :-) I think I'm starting to buy this.

I don't have any fixed standing points anything basically. It is
just better to be really resistant with anything that is related
to user-kernel interaction until you really get it...

/Jarkko
