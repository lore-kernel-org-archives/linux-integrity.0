Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr1-f52.google.com ([209.85.221.52]:42562 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbeIMTl1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Sep 2018 15:41:27 -0400
Received: by mail-wr1-f52.google.com with SMTP id v17-v6so5938930wrr.9
        for <linux-integrity@vger.kernel.org>; Thu, 13 Sep 2018 07:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAN19L9EEYK+OpJSCw+nNv7fCjkS5eQeAXfy=51nfk=fBZne-BA@mail.gmail.com>
 <1536848529.3436.2.camel@HansenPartnership.com>
In-Reply-To: <1536848529.3436.2.camel@HansenPartnership.com>
From: Martin Galvan <omgalvan.86@gmail.com>
Date: Thu, 13 Sep 2018 11:31:27 -0300
Message-ID: <CAN19L9HHqs7WdxsS7zYLvQ1vbsDpViyMb+Xfz1bG3=c2Jz-Mbg@mail.gmail.com>
Subject: Re: Question about the TPM driver
To: James.Bottomley@hansenpartnership.com
Cc: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi James, thanks for your answer.

El jue., 13 sept. 2018 a las 11:22, James Bottomley
(<James.Bottomley@hansenpartnership.com>) escribio:
>
> On Thu, 2018-09-13 at 10:14 -0300, Martin Galvan wrote:
> Exact buffer size hasn't been thought to be an issue since you know
> that any response will fit into MAX_RESPONSE_SIZE which the current
> implementation defines to be 4096.

Interesting, I didn't know about this max. I guess you're referring to
enum tpm_const's TPM_BUFSIZE constant, since I can't find this max in
the spec. In any case, what would be the effect of removing this
limitation and allowing a user to read the response in chunks rather
than having to allocate 4k every time? I don't think things would
break, though maybe I'm missing something.
