Return-Path: <SRS0=dywO=OM=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB542C04EBF
	for <linux-integrity@archiver.kernel.org>; Mon,  3 Dec 2018 18:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D5220850
	for <linux-integrity@archiver.kernel.org>; Mon,  3 Dec 2018 18:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DAx6aqGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D5220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbeLCSJx (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:09:53 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:37953 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbeLCSJx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Dec 2018 13:09:53 -0500
Received: by mail-pf1-f176.google.com with SMTP id q1so6772141pfi.5
        for <linux-integrity@vger.kernel.org>; Mon, 03 Dec 2018 10:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rdmF9jy0v1ECtxqYRj5YGFulPM9XKBVoo4oewOE8PS8=;
        b=DAx6aqGPDjGhixbKnx64880E9QDULYLRdd6y8HuuMeB4nTmfFhk/F7MTF0D5gjOLLh
         VlIYodhDl43c3ARS8UdwgRHMuGOQZ80b06Oa8Zu2g04hRF/KzE7Jz+zcLXCspiLyqAfN
         Vdsoe99M9KNTyXfnyR0vbYRzZcUYRqB9Eea1MA5GNKW+0zvJv1ZvApS9hywCG8fOYjdV
         DJ8djZ7X5p413FEQODnnJDIM3SzF8FFf5aNA+DBOBmGC5W1rtY7jS8J/JQHn6RPuLoAY
         pAYkGRzo+xOZS2xdQojeBDT1ost1t1jEmhsVYLvwo6PKnp05hdTe5UuqM4FDQsms4vCv
         ZoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rdmF9jy0v1ECtxqYRj5YGFulPM9XKBVoo4oewOE8PS8=;
        b=EdRhK0ZmjYoQLXRKxjtq+t/xZiUXQ6FXF1GdBG9tPY1tZJomkHKQIEbirtS6pFd1vd
         FCSAdmIKYvtBpUV16B/4lWDnFzNDqpEBshbZexSmjxNOjPfB2gQz4CQZqUc515mDCBao
         KQzlzfcslL3JNvWUucXX5n+83s3B0i3Z9hsLVGomZcT1nIofABi3OijpDji0fsKXihUv
         vTBMIOpuFYMzbH9GEQIF4vldeD7Vx8O9TffDy5DevfyuJmbOeXtrH1nDKYjVv5CIqb+u
         CMtFtoU0RqeBTg05dDNl6cS9/9qzcJEowdxrmyvHvsb458YQtqZCaUoRWgqxXg03SJni
         Rs4Q==
X-Gm-Message-State: AA+aEWbCUTJASx1m5VlUa9lefBOEULXszVNiW5S7KPvhuY66OMfzKWrp
        6pxL1x+nOOx+pZxmO2AZ4QNi4A==
X-Google-Smtp-Source: AFSGD/WL/PfbpevaDBXvyhZ0vabdyueZ59ODYxp79W+T50+EzZhO/HH90JrX31d6xzHkvtwCSZavtQ==
X-Received: by 2002:a63:f811:: with SMTP id n17mr14464361pgh.23.1543860589780;
        Mon, 03 Dec 2018 10:09:49 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id f32sm14230368pgf.80.2018.12.03.10.09.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 10:09:48 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gTsfD-0004he-RL; Mon, 03 Dec 2018 11:09:47 -0700
Date:   Mon, 3 Dec 2018 11:09:47 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Huewe <peterhuewe@gmx.de>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Re: Re: TPM legacy
Message-ID: <20181203180947.GD12237@ziepe.ca>
References: <20181130233501.GA32256@linux.intel.com>
 <1543764226.4216.205.camel@linux.ibm.com>
 <1543775366.2732.24.camel@HansenPartnership.com>
 <20181202231327.GC6718@linux.intel.com>
 <trinity-c862f498-65a2-43f4-a4b3-94cc4b8e1c66-1543849298447@3c-app-gmx-bs70>
 <20181203172922.GA12237@ziepe.ca>
 <20181203175509.GA10562@linux.intel.com>
 <20181203175546.GB10562@linux.intel.com>
 <4BE33FDA-128C-438E-8882-548B9E2848E9@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BE33FDA-128C-438E-8882-548B9E2848E9@gmx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 03, 2018 at 07:00:26PM +0100, Peter Huewe wrote:
> 
> 
> Am 3. Dezember 2018 18:55:46 MEZ schrieb Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>:
> >On Mon, Dec 03, 2018 at 09:55:09AM -0800, Jarkko Sakkinen wrote:
> >> On Mon, Dec 03, 2018 at 10:29:22AM -0700, Jason Gunthorpe wrote:
> >> > On Mon, Dec 03, 2018 at 04:01:38PM +0100, Peter Huewe wrote:
> >> > 
> >> > > The only thing I would want to get rid of are the *1.1b based*
> >> > > drivers - they are probably end of life since quite some time. 
> >The
> >> > > TIS driver&specification has been around since 2005 if not
> >longer...
> >> > 
> >> > I also wanted to do this, I feel like these drivers probably don't
> >> > work any more after all the churn in the past few years..
> >> 
> >> I'm with you on this but yeah, better to do it now so that it gets
> >> maximum exposure in linux-next (i.e. would land to 4.22).
> >
> >And superimportat to CC this commit also to LSM.
> >
> >/Jarkko
> Correct would be to move them to stagimg first.
> See my thread on ksummit-discuss for details.

I thought we decided not to do that anymore? Linus said just delete
them. If someone wants it back then git-revert will do the job.

If you want to do partways then flag the kconfig entries with
CONFIG_BROKEN for a cycle..

Jason
