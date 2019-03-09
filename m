Return-Path: <SRS0=9k+n=RM=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3B9C43381
	for <linux-integrity@archiver.kernel.org>; Sat,  9 Mar 2019 22:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2799E206DF
	for <linux-integrity@archiver.kernel.org>; Sat,  9 Mar 2019 22:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="wikqPzjC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfCIWo3 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 9 Mar 2019 17:44:29 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42196 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726340AbfCIWo3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 9 Mar 2019 17:44:29 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1588C8EE0D2;
        Sat,  9 Mar 2019 14:44:29 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HGuy2HB-sHov; Sat,  9 Mar 2019 14:44:28 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7E27C8EE02B;
        Sat,  9 Mar 2019 14:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1552171468;
        bh=jjShg79iiBtAdxt7AXBpXTvejkWZboyTFdXZci6x0Kw=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=wikqPzjCLQ0gIYJ3YJnQxrHiPihw/DDZn76NTiApXqMXT5z3ONU3hUm8/w6NZgGDY
         c4eOi31D8nAdqs+XEzvgw8YLdqB+p3HWlt2OmDyCBzLLl7i7KGgeWDCk/Om0hiA4rY
         CUklH0xJAQKRKypfaN/giwZRyRPKrspwAM5AS0oo=
Message-ID: <1552171467.3442.13.camel@HansenPartnership.com>
Subject: Re: Kernel 5.0 regression in /dev/tpm0 access
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Mantas =?UTF-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
        linux-integrity@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Sat, 09 Mar 2019 14:44:27 -0800
In-Reply-To: <1552168908.3442.5.camel@HansenPartnership.com>
References: <CAPWNY8Xg=Xyfdczqkiv+DNXh41ez1BH-KjcaJG9hcp_taOc+PA@mail.gmail.com>
         <1552168908.3442.5.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2019-03-09 at 14:01 -0800, James Bottomley wrote:
> On Sat, 2019-03-09 at 22:48 +0200, Mantas Mikulėnas wrote:
[...]
> openat(AT_FDCWD, "/dev/tpmrm0", O_RDWR) = 3
> write(3,
> "\200\1\0\0\0\26\0\0\1z\0\0\0\0\0\0\0\0\0\0\0@", 22) = 22
> read(3,
> "\200\1\0\0\0\235\0\0\0\0\0\0\0\0\0\0\0\0\27\0\1\0\0\0\t\0\4\0\0\0\4\
> 0"
> ..., 4096) = 157
> close(3)
> 
> So we do a simple write command and read the return (which simply
> hangs until the TPM is ready with the data).  We don't poll like your
> application does above, so it seems obvious that the break must be in
> the polling code.

OK, so the polled sequence should be 

write()
poll()
read()

So I think this condition in tpm_common_poll is the problem:

	if (!priv->response_read || priv->response_length)
		mask = EPOLLIN | EPOLLRDNORM;

If something wakes poll_wait() before the command returns, that
condition is true because we set response_read to false in write().  So
I think poll_wait() is returning prematurely.

The reason you don't often see the problem under tracing is that if the
queued work has time to execute *before* poll returns, it's taken the
mutex and the read() will block until the command completes trying to
acquire the mutex.  If you're fast enough, the queue doesn't run, the
mutex isn't taken and read acquires it and returns with no data.

I think the fix may be to make poll only return POLLIN if we have a
response_length, so

	if (priv->response_length)
			mask = EPOLLIN | EPOLLRDNORM;

That way the calling program will get POLLOUT and go back to re-polling 
until we have data.

James

