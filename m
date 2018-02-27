Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:48045 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbeB0CN2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Feb 2018 21:13:28 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        Dongsu Park <dongsu@kinvolk.io>,
        Alban Crequy <alban@kinvolk.io>
References: <1519053483-18396-1-git-send-email-zohar@linux.vnet.ibm.com>
        <1519053483-18396-2-git-send-email-zohar@linux.vnet.ibm.com>
        <87zi44mz26.fsf@xmission.com>
        <alpine.LRH.2.21.1802201152240.883@namei.org>
        <87tvucifji.fsf@xmission.com>
        <1519135329.3736.88.camel@linux.vnet.ibm.com>
        <20180220201636.GA1565@mail.hallyn.com>
        <1519224379.3736.154.camel@linux.vnet.ibm.com>
        <87mv02c65y.fsf@xmission.com>
        <1519253867.19593.25.camel@linux.vnet.ibm.com>
        <87r2peaqf0.fsf@xmission.com>
        <1519255954.3400.16.camel@linux.vnet.ibm.com>
Date: Mon, 26 Feb 2018 20:12:55 -0600
In-Reply-To: <1519255954.3400.16.camel@linux.vnet.ibm.com> (Mimi Zohar's
        message of "Wed, 21 Feb 2018 18:32:34 -0500")
Message-ID: <87606jw57c.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v1 1/2] ima: fail signature verification on untrusted filesystems
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> On Wed, 2018-02-21 at 17:12 -0600, Eric W. Biederman wrote:
>> 
>> As I understand the second scenario SB_I_IMA_UNVERIFIABLE_SIGNATURES
>> is set, which implies that the filesystem is lacking something for IMA
>> to reliably know when a file has changed.  AKA a technical deficiency.
>> 
>> The fourth scenario is the case when SB_I_IMA_UNVERIFIABLE_SIGNATURES
>> can be legitimately be cleared, because the filesystem provides all
>> of the necessary support for IMA to reliably know when a file has
>> changed.
>
> The information might be there, but IMA currently detects a file
> change and resets the flags only when the last writer calls
> __fput().  Any other time, new support would be needed.

My point was only that for local NTFS or local exFAT with a quality
and trusted fuse implementation they should be as safe in this regard
as any other filesystem.   So in theory we could have fuse implementing
this level of filesystem as well.  Not that I suggest we try for that
out of the gate.

Thank you very much for the clarification about the last fput that helps
me understand SB_I_IMA_UNVERIFIEDABLE_SIGNATURES much better.

Eric
