Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43108 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751643AbeBBOtq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Feb 2018 09:49:46 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w12EnG3m125733
        for <linux-integrity@vger.kernel.org>; Fri, 2 Feb 2018 09:49:46 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fvscst34s-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 02 Feb 2018 09:49:45 -0500
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 2 Feb 2018 14:49:44 -0000
Subject: Re: [GIT PULL] IMA bug fixes for 4.16
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Morris <jmorris@namei.org>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 02 Feb 2018 09:49:39 -0500
In-Reply-To: <alpine.LRH.2.21.1802022106130.2739@namei.org>
References: <1517510282.6675.13.camel@linux.vnet.ibm.com>
         <alpine.LRH.2.21.1802022106130.2739@namei.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1517582979.3171.46.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-02-02 at 21:07 +1100, James Morris wrote:
> On Thu, 1 Feb 2018, Mimi Zohar wrote:
> 
> > Hi James,
> > 
> > Included in this pull request are three bug fixes, assuming the 2 FUSE
> > patches are considered bugs and not new features, and a maintainer update.
> > I'd appreciate your sending them to Linus for 4.16.
> 
> I'd like to see an acked-by or reviewed-by from the FUSE maintainer 
> (cc'd), on the FUSE patches.

Ok.  For now, can you take the first two patches?

Mimi
