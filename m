Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56020 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751604AbeA2T6a (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Jan 2018 14:58:30 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0TJuvxo120293
        for <linux-integrity@vger.kernel.org>; Mon, 29 Jan 2018 14:58:30 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ft7j07rwf-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 29 Jan 2018 14:58:29 -0500
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 29 Jan 2018 19:58:27 -0000
Subject: Re: [RFC PATCH 0/2] IMA: Rewrite tests into new API + fixes
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@polito.it>
Date: Mon, 29 Jan 2018 14:58:23 -0500
In-Reply-To: <1517100440.29187.120.camel@linux.vnet.ibm.com>
References: <20180111202821.31639-1-pvorel@suse.cz>
         <1516815417.3686.55.camel@linux.vnet.ibm.com>
         <20180125203057.mzzpilp6i43xftka@dell5510>
         <1516919365.6513.72.camel@linux.vnet.ibm.com>
         <20180126175110.boaepz6dqe3uojq6@dell5510>
         <1517100440.29187.120.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1517255903.29187.560.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, 2018-01-27 at 19:47 -0500, Mimi Zohar wrote:
> On Fri, 2018-01-26 at 18:51 +0100, Petr Vorel wrote:


> > > > > Originally IMA allowed a builtin policy to be replaced with a custom
> > > > > policy, by simply cat'ing a file into the securityfs IMA policy file.
> > > > > Currently, if new rules can be added to the custom policy (Kconfig
> > > > > IMA_WRITE_POLICY enabled), the policy file must be signed.  Similarly,
> > > > > if the builtin "secure-boot" policy is defined on the boot command
> > > > > line, the custom policy must be signed.  Test "ima01 ima_policy.sh"
> > > > > should first detect if the policy must be signed, before running the
> > > > > tests.
> > 
> > > > Right, I'll check it. Is there other way how to detect it than reading
> > > > /boot/config-$(uname -r) or /proc/config.gz ? I'm asking because IMA might be using on
> > > > embedded devices (guessing from [2], [3]), which might not have either of them.
> > This is important. As Cyril agreed with me grepping /boot/config-$(uname -r) or
> > /proc/config.gz isn't good solution. I don't see any ioctl interface and
> > security/integrity/ima/ima_fs.c which handles IMA sysfs doesn't have this functionality.
> > Is it deliberate (security reason), that it's not exported to users?
> 
> This isn't really an IMA issue, but a TPM one.  The TPM device driver
> would need to export this information.

Sorry, that was an answer to the wrong question.  In ima_tpm.sh,
there's the question:

# Would be nice to know where the PCRs are located. Is this safe?".

Commit 313d21e "tpm: device class for tpm" moved the TPM sysfs
location from /sys/class/misc/tpmX/device/ to
/sys/class/tpm/tpmX/device/.  The pcrs are 


To answer your question, if after writing the custom policy, the
policy file disappears, then you obviously can't extend the policy.
 If the policy file doesn't disappear, you might not be able to extend
the policy, just view it.  Sorry, there's no method of knowing apriori
whether the policy can be extended.

Mimi
