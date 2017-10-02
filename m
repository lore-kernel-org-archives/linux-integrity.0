Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40934 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751062AbdJBTl7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Oct 2017 15:41:59 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v92Jcvh4121432
        for <linux-integrity@vger.kernel.org>; Mon, 2 Oct 2017 15:41:59 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dbp3danwj-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 02 Oct 2017 15:41:58 -0400
Received: from localhost
        by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 3 Oct 2017 05:41:56 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
        by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v92JfrwA43516092
        for <linux-integrity@vger.kernel.org>; Tue, 3 Oct 2017 06:41:53 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
        by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v92Jfvp4023602
        for <linux-integrity@vger.kernel.org>; Tue, 3 Oct 2017 06:41:57 +1100
Subject: Re: [PATCH 1/6] IMA: Allow EVM validation on appraisal even without
 a symmetric key
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity@vger.kernel.org
Date: Mon, 02 Oct 2017 15:41:50 -0400
In-Reply-To: <CACdnJuvzMKWNRSZy2LZUBv+qiPPDkm2ftNZ7RcdqbHXFP49bFg@mail.gmail.com>
References: <20170927221653.11219-1-mjg59@google.com>
         <20170927221653.11219-2-mjg59@google.com>
         <1506823682.5691.173.camel@linux.vnet.ibm.com>
         <CACdnJuvzMKWNRSZy2LZUBv+qiPPDkm2ftNZ7RcdqbHXFP49bFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1506973310.5691.292.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2017-10-02 at 10:02 -0700, Matthew Garrett wrote:
> On Sat, Sep 30, 2017 at 7:08 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > On Wed, 2017-09-27 at 15:16 -0700, Matthew Garrett wrote:
> >> A reasonable configuration is to use IMA to appraise a subset of files
> >> (based on user, security label or other features supported by IMA) but
> >> to also want to use EVM to validate not only the state of the IMA hash
> >> but also additional metadata on the file. Right now this is only
> >> possible if a symmetric key has been loaded, which may not be desirable
> >> in all cases (eg, one where EVM digital signatures are shipped to end
> >> systems rather than EVM HMACs being generated locally).
> >
> > Commit 26ddabfe96bb "evm: enable EVM when X509 certificate is loaded"
> > already allows EVM to be enabled without loading a symmetric key.
> 
> This only seems to be set if CONFIG_EVM_LOAD_X509 is set. Should there
> be some sort of callback to set this if a key is loaded onto the evm
> keyring at runtime?

Currently writing 1 to the securityfs file causes the EVM key to be
loaded.  I would extend the existing evm_write_key().  Writing 2, for
example, might skip attempting to load the EVM key.  You'll probably
want to make sure that a public key has been loaded first.

Mimi
