Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752028AbeAEPAG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jan 2018 10:00:06 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w05EwAxY137037
        for <linux-integrity@vger.kernel.org>; Fri, 5 Jan 2018 10:00:05 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fa9anx62u-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 05 Jan 2018 10:00:04 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 5 Jan 2018 15:00:02 -0000
Subject: Re: [GIT PULL] linux-integrity patches for
 4.16-security-next-general
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Roberto Sassu <roberto.sassu@huawei.com>,
        James Morris <jmorris@namei.org>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date: Fri, 05 Jan 2018 09:59:57 -0500
In-Reply-To: <4806797a-bb15-6996-6654-7e21d39b7699@huawei.com>
References: <1515159816.4418.7.camel@linux.vnet.ibm.com>
         <4806797a-bb15-6996-6654-7e21d39b7699@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1515164397.4418.11.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Roberto,

On Fri, 2018-01-05 at 15:55 +0100, Roberto Sassu wrote:
> On 1/5/2018 2:43 PM, Mimi Zohar wrote:
> > Hi James,
> > 
> > Mimi Zohar (2):
> >        ima: relax requiring a file signature for new files with zero length
> >        ima: support new "hash" and "dont_hash" policy actions
> Hi Mimi
> 
> I think there is an issue in the patch above.
> 
> +	/* HASH just sets the digital signature flag, nothing else */
> +	if ((action & IMA_HASH) && !(iint->flags & IMA_DIGSIG)) {
> 
> IMA_DIGSIG now is an atomic flag.

Yes, this caused me grief, but is fixed in next-integrity branch.

Mimi
