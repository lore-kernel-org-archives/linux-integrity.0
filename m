Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58126 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726730AbeHUV47 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Aug 2018 17:56:59 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180821183108.GC25543@ziepe.ca>
References: <20180821183108.GC25543@ziepe.ca> <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk> <153486703636.13066.16209594327379341518.stgit@warthog.procyon.org.uk>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: dhowells@redhat.com, denkenz@gmail.com,
        jarkko.sakkinen@linux.intel.com, jejb@linux.vnet.ibm.com,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        tpmdd-devel@lists.sourceforge.net,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 04/23] TPM: Expose struct tpm_chip and related find_get and put functions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 21 Aug 2018 19:35:41 +0100
Message-ID: <1508.1534876541@warthog.procyon.org.uk>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Jason Gunthorpe <jgg@ziepe.ca> wrote:

> I think this is already in the kernel .. Stephen did it.

As I said in the cover: one or two of these patches may already be upstream.

It's the state of the branch I had four years ago.

David
