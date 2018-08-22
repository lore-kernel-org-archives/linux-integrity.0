Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728207AbeHVSKT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Aug 2018 14:10:19 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180822141956.GA28110@linux.intel.com>
References: <20180822141956.GA28110@linux.intel.com> <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: dhowells@redhat.com, denkenz@gmail.com, jejb@linux.vnet.ibm.com,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        tpmdd-devel@lists.sourceforge.net,
        linux-security-module@vger.kernel.org
Subject: Re: tpm: Provide a TPM access library
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 22 Aug 2018 15:45:06 +0100
Message-ID: <13611.1534949106@warthog.procyon.org.uk>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

> Just a minor overal complaint: lower case for tags

You mean like TPM_TAG_RQU_COMMAND?

> (please do not send a newer version just because of that before I have time
> to review this).

I'd want to pull it up to current linus/master before posting again.

David
