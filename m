Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:35974 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751522AbeCTPBE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Mar 2018 11:01:04 -0400
MIME-Version: 1.0
In-Reply-To: <1521552744.22230.25.camel@linux.vnet.ibm.com>
References: <CABatt_zunDV_g3oR5_O5GMm0EVEnT0LEnmjp5PQgu26Q6T+4SA@mail.gmail.com>
 <1521206743.3503.29.camel@linux.vnet.ibm.com> <CABatt_zxC1W-OirRLM-PVERAkUZaJDSnRDc_i4a7ebh-NJZ9Ag@mail.gmail.com>
 <1521211762.3503.46.camel@linux.vnet.ibm.com> <77f5ac13-dd79-abf7-13b2-336bf799a25c@schaufler-ca.com>
 <CABatt_yk_73BsgaD7UsHOL9wse0FxR=i1YXneUfx6aUiBra_JQ@mail.gmail.com>
 <CABatt_zM0Uu2fEwyORKTLYMC2_KeqSkcye1toBxhyjkgOUr62Q@mail.gmail.com>
 <1521474460.3503.191.camel@linux.vnet.ibm.com> <CABatt_wfwRqJRie=eoaaXnfxd7EUBhDL-jPjPbBHbwcnpMWj7g@mail.gmail.com>
 <1521552744.22230.25.camel@linux.vnet.ibm.com>
From: Martin Townsend <mtownsend1973@gmail.com>
Date: Tue, 20 Mar 2018 15:01:01 +0000
Message-ID: <CABatt_yk+pgwxHVv+RY08xFDOfzxb4w6ELW7RxhW6gWQ=5Hvnw@mail.gmail.com>
Subject: Re: Problem mounting pseudo filesystems with SMACK and IMA enabled.
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Mar 20, 2018 at 1:32 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Tue, 2018-03-20 at 10:23 +0000, Martin Townsend wrote:
>> On Mon, Mar 19, 2018 at 3:47 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
>> > On Mon, 2018-03-19 at 14:37 +0000, Martin Townsend wrote:
>> > [...]
>> >> The problem was because systemd couldn't create directories for the
>> >> mounts /dev/shm and /sys/fs/cgroup/systemd, it was returning -ENOKEY.
>> >
>> > There's a disconnect between what ima-evm-utils supports and the
>> > kernel.  This sounds like the kernel you're using has directory
>> > support, which has not been upstreamed.
>> >
>> >> After investigating it looks like I need to set a key for HMAC to stop
>> >> the mkdir failing which I didn't appreciate I needed with a pre-signed
>> >> image.
>> >
>> >> I have a question on this, looking at the IMA code it will try and
>> >> replace my signatures with the HMAC unless the immutable attribute is
>> >> set, is this correct?
>> >
>> > EVM will replace the file signature with an HMAC, unless the
>> > filesystem is mounted r/o, is immutable, or is signed with the new EVM
>> > portable and immutable signature.
>> >
>> >>  In the evmctl utility there's mention of an evm
>> >> immutable flag but I see nothing in the kernel code that supports
>> >> this. Is this a feature that never made it into the kernel? or is it
>> >> there but I've missed it?
>> >
>> > The portable and immutable EVM signature is being added only in this
>> > release (linux-4.16).
>> >
>> >> Second question, I have no TPM module so do I need to add a key for
>> >> HMAC or is there another way? It's not a problem if I have to add a
>> >> key I just want to make 100% sure I have to before patching systemd or
>> >> creating my own init process that adds the key before handing over to
>> >> systemd.
>> >
>> > systemd already has support for loading an EVM key.
>> >
>> > The EVM encrypted key could be based on either a TPM trusted key or a
>> > user key, without the HW guarantees of the private key not being
>> > exposed in the clear.  If you don't need an EVM key, then without a
>> > TPM, you're probably better off backporting the new portable and
>> > immutable EVM key.
>>
>> I've taken a look at the kernel patch "EVM: Add support for portable
>> signature format" and this looks like the exact feature I've been
>> looking for :) and it applied fairly cleanly to 4.9 with just a couple
>> of easy manual edits.
>>
>> I upgraded to the latest 1.1 ima-evm-utils on my host system but I
>> can't sign any files with the --portable flag.  (I've added the
>> function failing to the log_err function)
>>
>> $ LD_LIBRARY_PATH=build/src/.libs sudo ./build/src/.libs/evmctl sign
>> --imasig -v -o --generation 0 --uuid  --key
>
> Can you try signing the file without "--generation 0 --uuid"?  Please
> provide the output of "getfattr -m ^security -e hex --dump
> <filename>".  The security.evm portable and immutable signature should
> begin with 0x05.
>
I get the following
LD_LIBRARY_PATH=build/src/.libs sudo ./build/src/.libs/evmctl sign
--imasig -o --key
/ws/rufilla/curtisswright/cwr-signing-authority/ca/ima/inter/private/ima-privkey.pem
/mnt/ubi/usr/bin/nsenter
ioctl() failed
errno: Inappropriate ioctl for device (25)

You can see in the hexdump from my previous post below it tries to
send a signature with 05 at the start.

Reverting back to 1.0 ima-evm-utils and hacking the kernel to add the
EVM key it booted but I couldn't add SMACK rules in fact I couldn't do
anything with smackfs and after further debugging it was because
IMA/EVM was measuring and appraising everything in /sys/fs/smack
With the following patch I have finally got SMACK and IMA working together:
