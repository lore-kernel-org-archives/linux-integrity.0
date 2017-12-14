Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51738 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752108AbdLNNLg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Dec 2017 08:11:36 -0500
Date: Thu, 14 Dec 2017 15:11:33 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Ken Goldman <kgold@linux.vnet.ibm.com>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
 fails
Message-ID: <20171214131133.xnkbyit4vbufk6vw@linux.intel.com>
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171120231512.6wpqgcggfta3am7m@linux.intel.com>
 <7c148cf0-2403-55cf-1633-ff326d5c6f7b@redhat.com>
 <20171121123006.esr7yxs5lvorlfjf@linux.intel.com>
 <476DC76E7D1DF2438D32BFADF679FC563F4BFC0B@ORSMSX115.amr.corp.intel.com>
 <20171126140646.hhjtyy26h5ebyd5a@linux.intel.com>
 <ec5d6e67-885b-a518-1c37-93eb3d49684e@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ec5d6e67-885b-a518-1c37-93eb3d49684e@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Dec 08, 2017 at 03:20:02PM -0500, Ken Goldman wrote:
> On 11/26/2017 9:06 AM, Jarkko Sakkinen wrote:
> > 
> > I think -EINVAL is better than synthetizing commands that are not really
> > from the TPM. And we would break backwards compatability by doing this.
> > 
> > As I said in an earlier response I would rather compare resource
> > manager to virtual memory than virtual machine.
> 
> Agreed that synthesizing a response is not trivial.  (It's not that hard
> either - a 6 byte hard coded header and a 4 byte big endian integer.)
> 
> But what would be wrong with sending an unknown command to the TPM and
> letting it handle the response?

Breaks the sandbox.

/Jarkko
