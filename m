Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35014 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754043AbeGEPQ4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Jul 2018 11:16:56 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65F9THI177370
        for <linux-integrity@vger.kernel.org>; Thu, 5 Jul 2018 11:16:55 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k1kexy4d6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 05 Jul 2018 11:16:55 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 5 Jul 2018 16:16:53 +0100
Subject: Re: ima: why IMA_APPRAISE_DIRECTORIES patch is not mainlined
From: Mimi Zohar <zohar@linux.ibm.com>
To: rishi gupta <gupt21@gmail.com>, zohar@linux.vnet.ibm.com,
        dmitry.kasatkin@gmail.com
Cc: linux-integrity@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Date: Thu, 05 Jul 2018 11:16:38 -0400
In-Reply-To: <CALUj-gtOL3wDoo=QC68zhnwOsnfBistA_X97WzWAu6_v5T-xWQ@mail.gmail.com>
References: <CALUj-gtOL3wDoo=QC68zhnwOsnfBistA_X97WzWAu6_v5T-xWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1530803798.3773.112.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

[CC'ing Dave Chinner, Ted Tso]

Hi Rishi,

On Thu, 2018-07-05 at 16:08 +0530, rishi gupta wrote:
> Hi Dmitry and security team members,
> 
> I am willing to take directory protection ima patch in a commercial
> product, but observed that it has not been mainlined. Is there any reason
> for not mainlining it. Are there any better options for protecting
> directory using IMA/EVM or some other security schemes.
> 
> https://lwn.net/Articles/512364/
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/kasatkin/linux-digsig/+/ima-dir-experimental/security/integrity/ima/ima_dir.c

The main purpose of the IMA-directory patch set is to protect file
names from offline attack.  Dmitry's patch set protects file names at
the immediate directory level, but does not extend up to the root
directory.  I brought up the topic of protecting file names at
LSF/MM[1].  Others in the community are aware of the problem and need
to be involved in the discussions as to how to address it.

[1] https://lwn.net/Articles/753276/

Mimi
