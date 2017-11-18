Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42876 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966216AbdKRXXk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 18 Nov 2017 18:23:40 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAINJ7xd042416
        for <linux-integrity@vger.kernel.org>; Sat, 18 Nov 2017 18:23:39 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2eak5jqdaw-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sat, 18 Nov 2017 18:23:39 -0500
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Sat, 18 Nov 2017 23:23:38 -0000
Subject: Re: [PATCH v2 06/15] ima: add parser of digest lists metadata
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Serge E. Hallyn" <serge@hallyn.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date: Sat, 18 Nov 2017 18:23:30 -0500
In-Reply-To: <20171118042030.GA13456@mail.hallyn.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
         <20171107103710.10883-7-roberto.sassu@huawei.com>
         <20171118042030.GA13456@mail.hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1511047410.5920.111.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Serge,

On Fri, 2017-11-17 at 22:20 -0600, Serge E. Hallyn wrote:
> On Tue, Nov 07, 2017 at 11:37:01AM +0100, Roberto Sassu wrote:
> > from a predefined position (/etc/ima/digest_lists/metadata), when rootfs
> > becomes available. Digest lists must be loaded before IMA appraisal is in
> > enforcing mode.
> 
> I'm sure there's a good reason for it, but this seems weird to me.
> Why read it from a file on disk instead of accepting it through say
> a securityfile write?

Assuming that the concept of a white list is something we want to
support, then at minimum the list needs to be signed and verified.
Instead of defining a new Kconfig pathname option, a securityfs file
could read it, like the IMA policy.

Mimi
