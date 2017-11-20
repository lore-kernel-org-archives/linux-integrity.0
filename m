Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751086AbdKTNxr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Nov 2017 08:53:47 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAKDodnt095534
        for <linux-integrity@vger.kernel.org>; Mon, 20 Nov 2017 08:53:46 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ebw9rbmjt-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 20 Nov 2017 08:53:46 -0500
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 20 Nov 2017 13:53:45 -0000
Subject: Re: [PATCH v2 06/15] ima: add parser of digest lists metadata
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Roberto Sassu <roberto.sassu@huawei.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date: Mon, 20 Nov 2017 08:53:40 -0500
In-Reply-To: <175600e1-c472-69fc-2b4d-4255d8e827b5@huawei.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
         <20171107103710.10883-7-roberto.sassu@huawei.com>
         <20171118042030.GA13456@mail.hallyn.com>
         <1511047410.5920.111.camel@linux.vnet.ibm.com>
         <175600e1-c472-69fc-2b4d-4255d8e827b5@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1511186020.4729.66.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2017-11-20 at 10:40 +0100, Roberto Sassu wrote:
> On 11/19/2017 12:23 AM, Mimi Zohar wrote:
> > Hi Serge,
> > 
> > On Fri, 2017-11-17 at 22:20 -0600, Serge E. Hallyn wrote:
> >> On Tue, Nov 07, 2017 at 11:37:01AM +0100, Roberto Sassu wrote:
> >>> from a predefined position (/etc/ima/digest_lists/metadata), when rootfs
> >>> becomes available. Digest lists must be loaded before IMA appraisal is in
> >>> enforcing mode.
> >>
> >> I'm sure there's a good reason for it, but this seems weird to me.
> >> Why read it from a file on disk instead of accepting it through say
> >> a securityfile write?
> 
> There are two reasons.
> 
> Digest lists must be loaded before any file is accessed, otherwise IMA
> will deny the operation if appraisal is in enforcing mode. With digest
> lists it is possible to appraise files in the initial ram disk without
> including extended attributes (the default policy excludes those files).

There are a number of people interested in extending CPIO to support
extended attributes, not just for IMA-appraisal. (Years ago I started
but unfortunately haven't had time to finish it.)  Isn't the right
solution to add extended attribute support to CPIO?

> The second reason is that appraisal has to be temporarily disabled
> because the file containing digest list metadata is not signed. The same
> happens when loading a public key (check ima_load_x509() in ima_init.c).

In terms of the x509 certificate, in order to validate the file
containing the x509 certificate, there needs to be a key on the IMA
keyring.

Since x509 certificates themselves are signed by a key on the builtin
keyring, it is safe to load them on the IMA keyring without first
validating the file signature.

Once a public key is loaded on the IMA keyring, all other file
signatures can be appraised.  There's no need for treating the digest
list file any differently than other files, as there is for the x509
certificate.

Mimi
