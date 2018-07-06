Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42716 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753294AbeGFL7V (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Jul 2018 07:59:21 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w66Bwpro114163
        for <linux-integrity@vger.kernel.org>; Fri, 6 Jul 2018 07:59:20 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k26h1khxw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 06 Jul 2018 07:59:20 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 6 Jul 2018 12:59:19 +0100
Subject: Re: Question on IMA Policy
From: Mimi Zohar <zohar@linux.ibm.com>
To: Martin Townsend <mtownsend1973@gmail.com>,
        linux-integrity@vger.kernel.org
Date: Fri, 06 Jul 2018 07:59:04 -0400
In-Reply-To: <CABatt_x4bQzLuvf2iOFLBevGLx+s8tmA+m1A+q1wFECiVCReTQ@mail.gmail.com>
References: <CABatt_x4bQzLuvf2iOFLBevGLx+s8tmA+m1A+q1wFECiVCReTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1530878344.12156.53.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Martin,

On Fri, 2018-07-06 at 10:46 +0100, Martin Townsend wrote:
> Hi,
> 
> If I have a root filesystem signed for IMA/EVM could I have a policy
> that says appraise every file on this filesystem.  Looking through the
> source code I think I could use
> 
> appraise fsuuid=uuid-of-root-fs appraise_type=imasig
> 
> Would this do what I want?

Yes, that looks right.  Remember all files on this filesystem will be
considered "immutable", meaning you won't be able to write/update
them, only delete them.

Mimi
