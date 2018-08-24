Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52416 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726492AbeHXNHB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Aug 2018 09:07:01 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180824084930.GA10266@linux.intel.com>
References: <20180824084930.GA10266@linux.intel.com> <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk> <153486706322.13066.3105842100625841410.stgit@warthog.procyon.org.uk> <20180824075227.GG3584@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: dhowells@redhat.com, denkenz@gmail.com, jejb@linux.vnet.ibm.com,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        tpmdd-devel@lists.sourceforge.net,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 08/23] TPMLIB: Break TPM bits out of security/keys/trusted.c
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 24 Aug 2018 10:33:10 +0100
Message-ID: <25340.1535103190@warthog.procyon.org.uk>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

> I could rebase them and make a patch set out of them when I have time.

Thanks.  I'm not going to do anything further with this until after the merge
window anyway.

And thanks for taking the time to look through the patches.  I just dumped the
entire patchset on you rather than weeding out the duplicate/obsolete patches
as I don't have time just now to port them to linus/master.

David
