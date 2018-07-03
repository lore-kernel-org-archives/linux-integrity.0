Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47530 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933274AbeGCTGd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Jul 2018 15:06:33 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w63J3sFL089197
        for <linux-integrity@vger.kernel.org>; Tue, 3 Jul 2018 15:06:33 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k0dpa38un-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 03 Jul 2018 15:06:32 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <jejb@linux.vnet.ibm.com>;
        Tue, 3 Jul 2018 13:06:32 -0600
Subject: Re: [PATCH 2/2] KEYS: trusted: Find tpm_chip and use it until
 module shutdown
From: James Bottomley <jejb@linux.vnet.ibm.com>
To: James Morris <jmorris@namei.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        keyrings@vger.kernel.org
Date: Tue, 03 Jul 2018 12:06:23 -0700
In-Reply-To: <alpine.LRH.2.21.1807040450340.32123@namei.org>
References: <20180626193040.2509798-1-stefanb@linux.vnet.ibm.com>
         <20180626193040.2509798-3-stefanb@linux.vnet.ibm.com>
         <edf4aeaab76713579016cb009a0e632d7417c5f8.camel@linux.intel.com>
         <1530631615.3142.6.camel@linux.vnet.ibm.com>
         <20180703165102.GB19800@linux.intel.com>
         <alpine.LRH.2.21.1807040450340.32123@namei.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1530644783.3142.37.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-07-04 at 04:51 +1000, James Morris wrote:
> On Tue, 3 Jul 2018, Jarkko Sakkinen wrote:
> 
> > On Tue, Jul 03, 2018 at 08:26:55AM -0700, James Bottomley wrote:
> > 
> > OK, I was not sure how that discussion went. I could add myself as
> > co-maintainer to MAINTAINERS because I anyway need to go through
> > all of these.
> > 
> > If anyone does not vote against, I'll send a patch.
> > 
> 
> For Keys?  That would would be useful to help reduce the workload on 
> David.

Well, no, this was for trusted keys, which is the part of the key
infrastructure that goes via the TPM: The KEYS-TRUSTED part in the
MAINTAINERs file.  There's still KEYS-ENCRYPTED, KEYS/KEYRING and
ASYMETRIC KEYS, which don't use the TPM.

However, I've no objection to consolidating the lot under a larger set
of maintainers ... I recently agreed to look at the asymmetric key TPM
patch because it's my area, but it also strays over into crypto,
keyring and asymmetric keys.

James
