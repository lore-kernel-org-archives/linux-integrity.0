Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:46058 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751972AbdI2TR2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Sep 2017 15:17:28 -0400
Received: by mail-it0-f49.google.com with SMTP id x15so962369itb.0
        for <linux-integrity@vger.kernel.org>; Fri, 29 Sep 2017 12:17:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506711726.5691.141.camel@linux.vnet.ibm.com>
References: <20170927221653.11219-1-mjg59@google.com> <1506629560.5691.33.camel@linux.vnet.ibm.com>
 <CACdnJuuveRvCx57ZnYmRWbiwh3XU7AbxZD2W-Gq_dh_h_6L9Mg@mail.gmail.com>
 <1506646397.5691.64.camel@linux.vnet.ibm.com> <CACdnJuueNfLdDnCsmotGhLC58cJXXh35FeZzipJ_ZshScPM=qA@mail.gmail.com>
 <1506711726.5691.141.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Fri, 29 Sep 2017 12:17:27 -0700
Message-ID: <CACdnJuvYNnePfz4H-D=DGMHbrbmZ52JWFoLqX120ALV=o4wwcw@mail.gmail.com>
Subject: Re: RFC: Make it practical to ship EVM signatures
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Sep 29, 2017 at 12:02 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Fri, 2017-09-29 at 11:09 -0700, Matthew Garrett wrote:
>> On Thu, Sep 28, 2017 at 5:53 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
>> > Without the inode included in the HMAC calculation, the same file
>> > could exist as a different file name on the same file system.  No need
>> > for the two files to be on different file systems.
>>
>> But if I create a hardlink to an existing file then I get the same
>> file with the same inode number and two different names on the same
>> filesystem, and so security.evm would still match?
>
> True, with a hard link that would be the case, but by the same file, I
> meant a copy of the original file, not a hard link to the file.

The difference doesn't seem that great, really? If I can copy a file
while retaining ownership, I can create a hardlink.

>> > Assuming you're using a trusted key (TPM based key) to encrypt/decrypt
>> > the EVM key (trusted key), then such an attack would require root
>> > privileges with the ability to read kernel memory.  The EVM key is
>> > never exposed to userspace in the clear.
>>
>> That's a case that we need to be worried about. Trusted boot means we
>> can ensure that a system boots an updated kernel, but if the attacker
>> has been able to drop a modified sshd with a valid hmac onto the
>> system then we have fewer guarantees about the integrity. We could
>> continue using signatures for security.ima to avoid that, but then we
>> lose the performance benefits of the hmac and also don't have the same
>> level of guarantees around the other security metadata.
>
> I think you mean "secure boot", not "trusted boot", in this case.

No, trusted - secure boot wouldn't reliably tell us which version of a
kernel had booted, trusted boot will.

> The original understanding was that IMA/EVM would enforce integrity
> and not enforce mandatory access control (MAC).  The LSMs (eg.
> SELinux) would be responsible for MAC.  Separation of duties.

The kernel's security track record isn't sufficient to be able to
assert that any kernel secrets can be kept secret, so we're left
wanting integrity guarantees without relying on that.

> With that understanding, if the LSM allows a file to be "dropped" onto
>  the file system of a running system, IMA/EVM will hash and hmac the
> permitted file.
>
> I don't understand where you're going with this train of thought.  If
> you're trying to make a case for EVM to run with only security.evm
> signatures, then you wouldn't refer to the HMAC benefits.  If you're
> trying to make a case for EVM signatures, with the inode they're not
> portable, without the inode, they are susceptible to a cut and paste
> attack.

I'm arguing that (for our case at least) the only way we can use IMA
is to rely on using a digital signature - we can either have that
digital signature be in security.ima, or we can have it in
security.evm. Since we need that signature in any case, we derive no
benefit from having security.evm be an hmac - our two reasonable
choices are:

1) security.ima as a digital signature, security.evm as an hmac
2) security.ima as a hash, security.evm as a digital signature

I'm not really clear on what attacks are prevented by using the inode
number. If I'm able to preserve all the other security metadata when
copying a file, I can just create a hardlink to the original instead
and have the same outcome.
