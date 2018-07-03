Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from namei.org ([65.99.196.166]:34604 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751950AbeGCSwl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Jul 2018 14:52:41 -0400
Date: Wed, 4 Jul 2018 04:51:35 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
cc: James Bottomley <jejb@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        keyrings@vger.kernel.org
Subject: Re: [PATCH 2/2] KEYS: trusted: Find tpm_chip and use it until module
 shutdown
In-Reply-To: <20180703165102.GB19800@linux.intel.com>
Message-ID: <alpine.LRH.2.21.1807040450340.32123@namei.org>
References: <20180626193040.2509798-1-stefanb@linux.vnet.ibm.com> <20180626193040.2509798-3-stefanb@linux.vnet.ibm.com> <edf4aeaab76713579016cb009a0e632d7417c5f8.camel@linux.intel.com> <1530631615.3142.6.camel@linux.vnet.ibm.com>
 <20180703165102.GB19800@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 3 Jul 2018, Jarkko Sakkinen wrote:

> On Tue, Jul 03, 2018 at 08:26:55AM -0700, James Bottomley wrote:
> 
> OK, I was not sure how that discussion went. I could add myself as
> co-maintainer to MAINTAINERS because I anyway need to go through
> all of these.
> 
> If anyone does not vote against, I'll send a patch.
> 

For Keys?  That would would be useful to help reduce the workload on 
David.

-- 
James Morris
<jmorris@namei.org>
