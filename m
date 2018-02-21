Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:42845 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbeBUWyK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Feb 2018 17:54:10 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: James Morris <jmorris@namei.org>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        Dongsu Park <dongsu@kinvolk.io>,
        Alban Crequy <alban@kinvolk.io>,
        "Serge E . Hallyn" <serge@hallyn.com>
References: <1519053483-18396-1-git-send-email-zohar@linux.vnet.ibm.com>
        <1519053483-18396-2-git-send-email-zohar@linux.vnet.ibm.com>
        <87zi44mz26.fsf@xmission.com>
        <alpine.LRH.2.21.1802201152240.883@namei.org>
        <87tvucifji.fsf@xmission.com>
        <1519135329.3736.88.camel@linux.vnet.ibm.com>
Date: Wed, 21 Feb 2018 16:53:27 -0600
In-Reply-To: <1519135329.3736.88.camel@linux.vnet.ibm.com> (Mimi Zohar's
        message of "Tue, 20 Feb 2018 09:02:09 -0500")
Message-ID: <87fu5uc5ug.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v1 1/2] ima: fail signature verification on untrusted filesystems
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> On Mon, 2018-02-19 at 20:02 -0600, Eric W. Biederman wrote:
>> It would also be nice if I could provide all of this information at
>> mount time (when I am the global root) with mount options.  So I don't
>> need to update all of my tooling to know how to update ima policy when I
>> am mounting a filesystem.
>
> The latest version of this patch relies on a builtin IMA policy to set
> a flag.  No other changes are required to the IMA policy.  This
> builtin policy could be used for environments not willing to accept
> the default unverifiable signature risk.

I still remain puzzled by this.  Why is the default to accept the risk?

Eric
