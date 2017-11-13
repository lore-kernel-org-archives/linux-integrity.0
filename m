Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40316 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753414AbdKMULW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Nov 2017 15:11:22 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vADKAIZr138125
        for <linux-integrity@vger.kernel.org>; Mon, 13 Nov 2017 15:11:21 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2e7fx3xk7v-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Nov 2017 15:11:21 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 13 Nov 2017 20:11:19 -0000
Subject: Re: [RFC PATCH v2] fw_lockdown: new micro LSM module to prevent
 loading unsigned firmware
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Kyle McMartin <kyle@kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
Date: Mon, 13 Nov 2017 15:11:12 -0500
In-Reply-To: <20171113195154.GE22894@wotan.suse.de>
References: <1510573414.3404.109.camel@linux.vnet.ibm.com>
         <20171113190505.GC22894@wotan.suse.de>
         <1510601807.3711.16.camel@linux.vnet.ibm.com>
         <20171113195154.GE22894@wotan.suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1510603872.3711.36.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2017-11-13 at 20:51 +0100, Luis R. Rodriguez wrote:
> On Mon, Nov 13, 2017 at 02:36:47PM -0500, Mimi Zohar wrote:

> > Huh, I kind of lost you here.  What does "it" refer to in the above
> > sentence?  IMA is in the kernel.  So, who does what checks in
> > userspace?
> 
> Sorry I thought some checks were done in userspace, given that is clarified,
> what I meant is that say a device driver has a signing specification written
> out in the driver, should/can IMA use that on the LSM to verify the detached
> signature file for the firmware?

IMA-appraisal currently supports file signatures as extended
attributes.  Thiago Bauermann posted patches for including appended
signature support to IMA-appraisal.  If someone is interested in
adding detached signature support, they're welcome to do so.

> If it can be all done in kernel, it has me wondering if perhaps one option for
> IMA might be to do only vetting for these types of checks, where the info and
> description to appraise files is all in-kernel. IMA would not be required
> for other files.

We probably can defer this discussion until it is applicable.

Mimi
