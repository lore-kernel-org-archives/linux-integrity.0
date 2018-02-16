Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:54494 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759016AbeBPRsj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Feb 2018 12:48:39 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        Dongsu Park <dongsu@kinvolk.io>,
        Alban Crequy <alban@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <1518615315-7162-1-git-send-email-zohar@linux.vnet.ibm.com>
        <1518615315-7162-2-git-send-email-zohar@linux.vnet.ibm.com>
        <87po57yvix.fsf@xmission.com>
        <1518698285.5667.87.camel@linux.vnet.ibm.com>
        <87a7wayzcl.fsf@xmission.com>
        <1518717140.5667.145.camel@linux.vnet.ibm.com>
Date: Fri, 16 Feb 2018 11:48:00 -0600
In-Reply-To: <1518717140.5667.145.camel@linux.vnet.ibm.com> (Mimi Zohar's
        message of "Thu, 15 Feb 2018 12:52:20 -0500")
Message-ID: <87d114ygfj.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: Re: [RFC PATCH 2/4] ima: fail signature verification on unprivileged & untrusted filesystems
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> On Thu, 2018-02-15 at 10:47 -0600, Eric W. Biederman wrote:
>> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
>> 
>> > On Wed, 2018-02-14 at 17:57 -0600, Eric W. Biederman wrote:
>> >> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
>> >> 
>> >> > Files on untrusted filesystems, such as fuse, can change at any time,
>> >> > making the measurement(s) and by extension signature verification
>> >> > meaningless.
>> >> >
>> >> > FUSE can be mounted by unprivileged users either today with fusermount
>> >> > installed with setuid, or soon with the upcoming patches to allow FUSE
>> >> > mounts in a non-init user namespace.
>> >> >
>> >> > This patch always fails the file signature verification on unprivileged
>> >> > and untrusted filesystems.  To also fail file signature verification on
>> >> > privileged, untrusted filesystems requires a custom policy.
>> >> >
>> >> > (This patch is based on Alban Crequy's use of fs_flags and patch
>> >> >  description.)
>> >> 
>> >> This would be much better done based on a flag in s_iflags and then the
>> >> mounts that need this can set this.  That new flag can perhaps be called
>> >> SB_I_IMA_FAIL.
>> >> 
>> >> Among other things that should allow the policy of when to set this to
>> >> be set in fuse where it is obvious rather than in an magic location in
>> >> IMA.
>> >
>> > Using s_iflags instead of fs_flags is fine, but I'm not sure how this
>> > affects the IMA policy.  This patch set assumes only unprivileged,
>> > untrusted filesytems can automatically fail file signature
>> > verification (2nd patch), as that hasn't yet been upstreamed and won't
>> > break userspace.
>> >
>> > Based on policy, IMA should additionally be able to fail the signature
>> > verification for files on privileged, untrusted filesystems.
>> 
>> Apologies ima has a very specific meaning of policy, as in the loaded
>> ima policy.  I was meaning the hard coded policy of which filesystems
>> we simply would not trust by default.
>> 
>> In code terms what I was thinking would look something like:
>> 
>> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
>> --- a/security/integrity/ima/ima_appraise.c
>> +++ b/security/integrity/ima/ima_appraise.c
>> @@ -292,7 +292,14 @@ int ima_appraise_measurement(enum ima_hooks func,
>>  	}
>>   
>>  out:
>> -	if (status != INTEGRITY_PASS) {
>> +	/* Fail if we can't trust the fs enough to support ima xattrs (FUSE) */
>> +	if (inode->i_sb->s_iflags & SB_I_NOIMA) {
>> +		status = INTEGRITY_FAIL;
>> +		cause = "untrusted-filesystem";
>> +		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
>> +				    op, cause, rc, 0);
>> +	} else if (status != INTEGRITY_PASS) {
>>  		if ((ima_appraise & IMA_APPRAISE_FIX) &&
>>  		    (!xattr_value ||
>>   		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
>> 
>> And somewhere in the fuse mount code it would say:
>> 
>> 	if (sb->s_user_ns != &init_user_ns)
>>         	sb->s_iflags |= SB_I_NOIMA);
>
> SB_I_NOIMA would be really confusing, as we're not disabling IMA in
> general, just failing the signature verification.  The measurement,
> even if it is meaningless, is an indication in the measurement list
> that the file was accessed/executed.
>
> I would propose naming the flag SB_I_IMA_UNTRUSTED, meaning the kernel
> is unaware of fs changes.

Fair enough on the naming.  You understand the nuiances the better than
I.


>> The point being that the logic for setting the flag can live in fuse or
>> a simpler filesystem and all ima proper needs to do is deal with the flag being
>> set.  That should be easier to maintainer and simpler to code all
>> around.
>
> The last patch (4/4) had 1 line, which set the fs_flags
> unconditionally in fuse_fs_type.  Instead, we can set the sb->s_iflags 
> in fuse_fill_supper(), again unconditionally, letting IMA-appraisal
> differentiate between privileged and unprivileged.

I really think that is a bad way to structure the code.

I strongly suspect when everything settles down the test needs to be:

	if (!fc->allow_other || (sb->s_user_ns != &init_user_ns))
        	sb->s_iflags |= SB_I_IMA_UNTRUSTED;

fc->allow_other is only set on a very trusted mount of fuse.

Or it might be that fuse decides that breaking it's users by default is
a good idea and always sets SB_I_IMA_UNTRUSTED.  Unless a new mount
option is specified.

How much trust we place in the file server in general is a fuse specific
problem, that the fuse kernel code should handle.  So half of the test
should not reside in IMA and half of the test in the fuse filesystem
code.

The test should reside in fuse and the IMA code should honor it.

I suspect for nfs the situation will be different.  By default we will
trust the server but there will be situations we don't want to and
having a mount option that changes that default would be nice.  (Plus
maybe someday unprivileged nfs mounts that we never want to trust).

I can also see making decisions like this based on the question are the
network transfers authenticated aka signed.

Everything I am seeing says that it makes a lot of sense to have the
capability in the ima code, and the decision to use that capability in
the trust kernel part of the fs code.  As far as I can see that is a
proper separation of responsibilities.

Eric
