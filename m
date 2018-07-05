Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from ipmail03.adl2.internode.on.net ([150.101.137.141]:16120 "EHLO
        ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753172AbeGEXB5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Jul 2018 19:01:57 -0400
Date: Fri, 6 Jul 2018 08:56:51 +1000
From: Dave Chinner <david@fromorbit.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: rishi gupta <gupt21@gmail.com>, zohar@linux.vnet.ibm.com,
        dmitry.kasatkin@gmail.com, linux-integrity@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: ima: why IMA_APPRAISE_DIRECTORIES patch is not mainlined
Message-ID: <20180705225650.GV19934@dastard>
References: <CALUj-gtOL3wDoo=QC68zhnwOsnfBistA_X97WzWAu6_v5T-xWQ@mail.gmail.com>
 <1530803798.3773.112.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1530803798.3773.112.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Jul 05, 2018 at 11:16:38AM -0400, Mimi Zohar wrote:
> [CC'ing Dave Chinner, Ted Tso]
> 
> Hi Rishi,
> 
> On Thu, 2018-07-05 at 16:08 +0530, rishi gupta wrote:
> > Hi Dmitry and security team members,
> > 
> > I am willing to take directory protection ima patch in a commercial
> > product, but observed that it has not been mainlined. Is there any reason
> > for not mainlining it. Are there any better options for protecting
> > directory using IMA/EVM or some other security schemes.
> > 
> > https://lwn.net/Articles/512364/
> > https://kernel.googlesource.com/pub/scm/linux/kernel/git/kasatkin/linux-digsig/+/ima-dir-experimental/security/integrity/ima/ima_dir.c
> 
> The main purpose of the IMA-directory patch set is to protect file
> names from offline attack.  Dmitry's patch set protects file names at
> the immediate directory level, but does not extend up to the root
> directory.  I brought up the topic of protecting file names at
> LSF/MM[1].  Others in the community are aware of the problem and need
> to be involved in the discussions as to how to address it.

Probably best to take any discussion to the -fsdevel list. Verifying
directories are unchanged doesn't guarantee that access to
individual files is unchanged, though. Hardlinks can be made
from outside the verified directory and symlinks can cross
filesystem boundaries from outside verified filesystems...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
