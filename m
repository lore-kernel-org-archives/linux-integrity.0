Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:39180 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932297AbeBTCDk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Feb 2018 21:03:40 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: James Morris <jmorris@namei.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
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
Date: Mon, 19 Feb 2018 20:02:57 -0600
In-Reply-To: <alpine.LRH.2.21.1802201152240.883@namei.org> (James Morris's
        message of "Tue, 20 Feb 2018 11:52:42 +1100 (AEDT)")
Message-ID: <87tvucifji.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v1 1/2] ima: fail signature verification on untrusted filesystems
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

James Morris <jmorris@namei.org> writes:

> On Mon, 19 Feb 2018, Eric W. Biederman wrote:
>
>> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
>> 
>> > Files on untrusted filesystems, such as fuse, can change at any time,
>> > making the measurement(s) and by extension signature verification
>> > meaningless.
>> 
>> Filesystems with servers?
>> Remote filesystems?
>> Perhaps unexpected changes.
>> 
>> Untrusted sounds a bit harsh, and I am not certain it quite captures
>> what you are looking to avoid.
>
> Right -- I think whether you trust a filesystem or not depends on how much 
> assurance you have in your specific configuration, rather than whether you 
> think the filesystem can be manipulated or not.
>
> There is a difference between:
>
>   - This fs has no way to communicate a change to IMA, and;
>
>   - This fs could be malicious.
>
> In the latter case, I suggest that any fs could be malicious if the 
> overall security policy / settings are inadequate for the threat model, or 
> if there are vulnerabilities which allow such security to be bypassed.
>
> Whether a user trusts FUSE on their particular system should be a policy 
> decision on the part of the user.  The kernel should not be deciding what 
> is trusted or not trusted here.

I believe there has been a good techincal argument made that fuse
mounted by an malicious user can defeat the protections ima is trying to
provide.

In particular the file could change after the signature of the file has
been verified without ima being alerted.

As such I think it is very reasonable for ima when a fuse filesystem has
been mounted by an unprivileged user to report that it can not verify
signatures, because IMA can not verify signatures in a meaningful way.

Now that might be better called SB_I_IMA_UNVERIFIABLE_SIGNATURES.

We may want to complement that flag with SB_I_UNTRUSTED_MOUNTER.
For the times when it is not the global root user who mounts
the filesystem.

So I do think when both conditions are true there very much is a case
for the kernel saying realizing it would be stupid to trust sigantures
it can not reliably verify.

On the flip side when it really is a trusted mounter, and it is in a
configuration that IMA has a reasonable expectation of seeing all of
the changes it would be nice if we can say please trust this mount.

It would also be nice if I could provide all of this information at
mount time (when I am the global root) with mount options.  So I don't
need to update all of my tooling to know how to update ima policy when I
am mounting a filesystem.

Eric
