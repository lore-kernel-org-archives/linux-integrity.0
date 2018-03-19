Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60070 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933693AbeCSPr5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Mar 2018 11:47:57 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2JFljPo088216
        for <linux-integrity@vger.kernel.org>; Mon, 19 Mar 2018 11:47:56 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gtevcm46f-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 19 Mar 2018 11:47:55 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 19 Mar 2018 15:47:45 -0000
Subject: Re: Problem mounting pseudo filesystems with SMACK and IMA enabled.
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Martin Townsend <mtownsend1973@gmail.com>,
        linux-integrity@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
        Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Date: Mon, 19 Mar 2018 11:47:40 -0400
In-Reply-To: <CABatt_zM0Uu2fEwyORKTLYMC2_KeqSkcye1toBxhyjkgOUr62Q@mail.gmail.com>
References: <CABatt_zunDV_g3oR5_O5GMm0EVEnT0LEnmjp5PQgu26Q6T+4SA@mail.gmail.com>
         <1521206743.3503.29.camel@linux.vnet.ibm.com>
         <CABatt_zxC1W-OirRLM-PVERAkUZaJDSnRDc_i4a7ebh-NJZ9Ag@mail.gmail.com>
         <1521211762.3503.46.camel@linux.vnet.ibm.com>
         <77f5ac13-dd79-abf7-13b2-336bf799a25c@schaufler-ca.com>
         <CABatt_yk_73BsgaD7UsHOL9wse0FxR=i1YXneUfx6aUiBra_JQ@mail.gmail.com>
         <CABatt_zM0Uu2fEwyORKTLYMC2_KeqSkcye1toBxhyjkgOUr62Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1521474460.3503.191.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-03-19 at 14:37 +0000, Martin Townsend wrote:
[...]
> The problem was because systemd couldn't create directories for the
> mounts /dev/shm and /sys/fs/cgroup/systemd, it was returning -ENOKEY.

There's a disconnect between what ima-evm-utils supports and the
kernel.  This sounds like the kernel you're using has directory
support, which has not been upstreamed.
  
> After investigating it looks like I need to set a key for HMAC to stop
> the mkdir failing which I didn't appreciate I needed with a pre-signed
> image.

> I have a question on this, looking at the IMA code it will try and
> replace my signatures with the HMAC unless the immutable attribute is
> set, is this correct?

EVM will replace the file signature with an HMAC, unless the
filesystem is mounted r/o, is immutable, or is signed with the new EVM
portable and immutable signature.

>  In the evmctl utility there's mention of an evm
> immutable flag but I see nothing in the kernel code that supports
> this. Is this a feature that never made it into the kernel? or is it
> there but I've missed it?

The portable and immutable EVM signature is being added only in this
release (linux-4.16).

> Second question, I have no TPM module so do I need to add a key for
> HMAC or is there another way? It's not a problem if I have to add a
> key I just want to make 100% sure I have to before patching systemd or
> creating my own init process that adds the key before handing over to
> systemd.

systemd already has support for loading an EVM key.

The EVM encrypted key could be based on either a TPM trusted key or a
user key, without the HW guarantees of the private key not being
exposed in the clear.  If you don't need an EVM key, then without a
TPM, you're probably better off backporting the new portable and
immutable EVM key.

Mimi
