Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38468 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752155AbdI2UDJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Sep 2017 16:03:09 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8TJx5WD040615
        for <linux-integrity@vger.kernel.org>; Fri, 29 Sep 2017 16:03:09 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2d9sqaghv8-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 29 Sep 2017 16:03:09 -0400
Received: from localhost
        by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Sat, 30 Sep 2017 06:03:05 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
        by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v8TK1mKa52756480
        for <linux-integrity@vger.kernel.org>; Sat, 30 Sep 2017 06:01:48 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
        by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v8TK1dAo014919
        for <linux-integrity@vger.kernel.org>; Sat, 30 Sep 2017 06:01:39 +1000
Subject: Re: RFC: Make it practical to ship EVM signatures
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-integrity@vger.kernel.org,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Date: Fri, 29 Sep 2017 16:01:44 -0400
In-Reply-To: <CACdnJuvYNnePfz4H-D=DGMHbrbmZ52JWFoLqX120ALV=o4wwcw@mail.gmail.com>
References: <20170927221653.11219-1-mjg59@google.com>
         <1506629560.5691.33.camel@linux.vnet.ibm.com>
         <CACdnJuuveRvCx57ZnYmRWbiwh3XU7AbxZD2W-Gq_dh_h_6L9Mg@mail.gmail.com>
         <1506646397.5691.64.camel@linux.vnet.ibm.com>
         <CACdnJuueNfLdDnCsmotGhLC58cJXXh35FeZzipJ_ZshScPM=qA@mail.gmail.com>
         <1506711726.5691.141.camel@linux.vnet.ibm.com>
         <CACdnJuvYNnePfz4H-D=DGMHbrbmZ52JWFoLqX120ALV=o4wwcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1506715304.5691.151.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2017-09-29 at 12:17 -0700, Matthew Garrett wrote:

> > The original understanding was that IMA/EVM would enforce integrity
> > and not enforce mandatory access control (MAC).  The LSMs (eg.
> > SELinux) would be responsible for MAC.  Separation of duties.
> 
> The kernel's security track record isn't sufficient to be able to
> assert that any kernel secrets can be kept secret, so we're left
> wanting integrity guarantees without relying on that.
> 
> > With that understanding, if the LSM allows a file to be "dropped" onto
> >  the file system of a running system, IMA/EVM will hash and hmac the
> > permitted file.
> >
> > I don't understand where you're going with this train of thought.  If
> > you're trying to make a case for EVM to run with only security.evm
> > signatures, then you wouldn't refer to the HMAC benefits.  If you're
> > trying to make a case for EVM signatures, with the inode they're not
> > portable, without the inode, they are susceptible to a cut and paste
> > attack.
> 
> I'm arguing that (for our case at least) the only way we can use IMA
> is to rely on using a digital signature - we can either have that
> digital signature be in security.ima, or we can have it in
> security.evm. Since we need that signature in any case, we derive no
> benefit from having security.evm be an hmac - our two reasonable
> choices are:
> 
> 1) security.ima as a digital signature, security.evm as an hmac
> 2) security.ima as a hash, security.evm as a digital signature

There's a major difference between security.ima containing a file hash
vs a signature.  A signature, assuming the file_check hook is in
policy, prevents the file from being modified, making the file
"immutable".

> I'm not really clear on what attacks are prevented by using the inode
> number. If I'm able to preserve all the other security metadata when
> copying a file, I can just create a hardlink to the original instead
> and have the same outcome.

The issue is the ability of having different security metadata, not
the same security metadata. (I need to refresh my memory as to hard
links, and whether they can have different security metadata.)

Originally the UUID was not included in the HMAC calculation.  Perhaps
the patch description of commit 74de668 "evm: add file system uuid to
EVM hmac" will help clarify the reasoning for including the inode and
uuid in the hmac calculation.

Mimi
