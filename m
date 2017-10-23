Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38920 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751150AbdJWKWS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Oct 2017 06:22:18 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9NAJhVO064861
        for <linux-integrity@vger.kernel.org>; Mon, 23 Oct 2017 06:22:17 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dsa7njvn8-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 23 Oct 2017 06:22:17 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 23 Oct 2017 11:22:15 +0100
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v9NAMARr27459654
        for <linux-integrity@vger.kernel.org>; Mon, 23 Oct 2017 10:22:12 GMT
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
        by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v9NAMAl2016737
        for <linux-integrity@vger.kernel.org>; Mon, 23 Oct 2017 21:22:10 +1100
Subject: Re: Behaviour regarding scripts when enforcing digital signatures
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthias Gerstner <mgerstner@suse.de>,
        linux-integrity@vger.kernel.org
Date: Mon, 23 Oct 2017 06:22:07 -0400
In-Reply-To: <20171020152853.v3vzemp2t54ljgwg@f195.suse.de>
References: <20171020152853.v3vzemp2t54ljgwg@f195.suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508754127.3639.39.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2017-10-20 at 17:28 +0200, Matthias Gerstner wrote:
> Hi,
> 
> I'm currently experimenting with enforcing digital signatures for all
> root owned files and all files executed by root.
> 
> To achieve this I've created appropriate digital signatures in the
> security.ima attribute for all relevant files and loaded a policy like
> this:
> 
>     [default dont_appraise/dont_measure lines]
>     appraise func=BPRM_CHECK fowner=0 appraise_type=imasig
>     appraise func=FILE_MMAP fowner=0 mask=MAY_EXEC appraise_type=imasig
>     appraise func=MODULE_CHECK appraise_type=imasig
>     appraise func=FIRMWARE_CHECK appraise_type=imasig
> 
> This works fine so far and any files without a correct signature cannot
> be executed any more.
> 
> There is one issue with scripts, however. In practice scripts can
> always be executed even if they don't have digital signatures when they
> are passed explicitly to the interpreter like:
> 
>     /bin/bash /root/my_unsigned_script.sh
> 
> However, when executed implicitly via the shebang line, the execution
> will be prevented:
> 
>     $ /root/my_unsigned_script.sh
>     -bash: /root/my_unsigned_script.sh: Permission denied
> 
> I can see that preventing execution of unsigned scripts is difficult to
> achieve. However I'd like to make it possible to run scripts the usual
> way at least, without having to sign them or passing them to the
> interpeter explicitly. This way system administrators can write and
> handle custom scripts the way they are used to.
> 
> As far as I see it, allowing this is not possible at the moment given
> the currently available policy grammar. Can you confirm this?
> 
> Would it be possible to add this as a feature? I think the
> func=BPRM_CHECK could support an additional limiting condition.
> Something like:
> 
>     appraise func=BPRM_CHECK fowner=0 appraise_type=imasig permit_scripts
> 
> The code on the kernel side looks not like it would easily allow this,
> though. In search_binary_handler() the call to security_bprm_check() is
> made before we know which binfmt handler applies and whether we're
> dealing with a script. Maybe somebody does have additional thoughts on
> this anyways.

The same method that shebang uses for differentiating the interpreter
from the script could be used to implement "permit_scripts".  The
problem would be cleanly passing this information from the bprm_check
hook to process_measurement().

> Another question on a related topic: Is it possible to enforce a minimum
> key length and digest algorithm for signatures?

And the following question, would be is it possible to require
different keys for different IMA rules based on LSM labels?

The "Cryptography and key management", which has been on the Linux
Security Summit CFP for the past two years, still needs to be
addressed.

Mimi
