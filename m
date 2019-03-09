Return-Path: <SRS0=9k+n=RM=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF45C43381
	for <linux-integrity@archiver.kernel.org>; Sat,  9 Mar 2019 22:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43DCD206DF
	for <linux-integrity@archiver.kernel.org>; Sat,  9 Mar 2019 22:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="GsOmqJLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfCIWBv (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 9 Mar 2019 17:01:51 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:41640 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726341AbfCIWBv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 9 Mar 2019 17:01:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A722B8EE0D2;
        Sat,  9 Mar 2019 14:01:50 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2EgwVN9jlj8w; Sat,  9 Mar 2019 14:01:50 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1D0678EE02B;
        Sat,  9 Mar 2019 14:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1552168910;
        bh=B8ha5lBN+OedcGMfZRDTxKMxDOxYl/UzNWXt4FNUVVM=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=GsOmqJLaOmTqg4YqrKGuZanIhW6uA5QSnzQhJrE+So5D1hGEKQMSYfRsNG1cIo03a
         jYD1H+fKo9O6XRHSK1LtuxBEdtvVbRf5upmLnCVU6k+mukkem2nR5riAHdWrhtyaQy
         YUJ9MaNsVz+l0H+/Jr6E60obpUTCpg65ytm1BMlE=
Message-ID: <1552168908.3442.5.camel@HansenPartnership.com>
Subject: Re: Kernel 5.0 regression in /dev/tpm0 access
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Mantas =?UTF-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
        linux-integrity@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Sat, 09 Mar 2019 14:01:48 -0800
In-Reply-To: <CAPWNY8Xg=Xyfdczqkiv+DNXh41ez1BH-KjcaJG9hcp_taOc+PA@mail.gmail.com>
References: <CAPWNY8Xg=Xyfdczqkiv+DNXh41ez1BH-KjcaJG9hcp_taOc+PA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2019-03-09 at 22:48 +0200, Mantas Mikulėnas wrote:
> Hello, I'm not entirely sure where I'm supposed to send this –
> 
> As of kernel 5.0.0, I'm unable to use the TPM on my laptop (HP
> EliteBook 840 G4, with Infineon TPM 2.0) with the current version of
> Intel TPM2 tools (tpm2-tss 2.2.0, tpm2-tools 3.1.3). The tools – e.g.
> tpm2_pcrlist or tpm2_nvread – sometimes succeed, sometimes are unable
> to read anything from /dev/tpm0 at all (immediately report an EOF),
> and sometimes are able to read part of the response but stop halfway.

Just as a data point, I don't see this on 5.0 with my setup.  However,
unlike you I'm using the ibmtss which makes direct connections to
/dev/tpmrm0 so our two situations definitely aren't equivalent.

> The problem seems to be caused by commit 9488585b21bef0df12 ("tpm:
> add support for partial reads"); I've compiled 5.0.0 with that commit
> reverted and the tpm2 tools no longer have problems. Investigating
> with `strace` shows that the tools frequently get 0 bytes out of a 4k
> read:
> 
> [good]
> write(3,
> "\200\1\0\0\0\32\0\0\1~\0\0\0\2\0\4\3\0\0\0\0\v\3\0\377\377", 26) =
> 26
> poll([{fd=3, events=POLLIN}], 1, -1)    = 1 ([{fd=3,
> revents=POLLIN}])
> read(3,
> "\200\1\0\0\0012\0\0\0\0\0\0\0h\0\0\0\2\0\4\3\0\0\0\0\v\3\0\377\0\0\0
> "...,
> 4096) = 306
> 
> [bad]
> write(3, "\200\1\0\0\0\32\0\0\1~\0\0\0\2\0\4\3\0\0\0\0\v\3\0\0\377",
> 26) = 26
> poll([{fd=3, events=POLLIN}], 1, -1)    = 1 ([{fd=3,
> revents=POLLIN}])
> read(3, "", 4096)                       = 0
> write(2, "WARNING:tcti:src/tss2-tcti/tcti-"..., 97) = 97
> write(2, "ERROR: ", 7)                  = 7
> write(2, "read pcr failed. tpm error 0xa00"..., 34) = 34
> 
> (Interestingly, this is very difficult to reproduce under strace, yet
> almost guaranteed to happen when not being traced. It almost feels as
> if this is a timing issue?)

There is a significant difference in the way our applications are
working.  for instance if I strace

tssgetcapability -cap 0

I see this (cutting out everything before the TPM open and after the
TPM close)

openat(AT_FDCWD, "/dev/tpmrm0", O_RDWR) = 3
write(3,
"\200\1\0\0\0\26\0\0\1z\0\0\0\0\0\0\0\0\0\0\0@", 22) = 22
read(3,
"\200\1\0\0\0\235\0\0\0\0\0\0\0\0\0\0\0\0\27\0\1\0\0\0\t\0\4\0\0\0\4\0"
..., 4096) = 157
close(3)

So we do a simple write command and read the return (which simply hangs
until the TPM is ready with the data).  We don't poll like your
application does above, so it seems obvious that the break must be in
the polling code.

James

