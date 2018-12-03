Return-Path: <SRS0=dywO=OM=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42CBC04EB9
	for <linux-integrity@archiver.kernel.org>; Mon,  3 Dec 2018 17:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7C420850
	for <linux-integrity@archiver.kernel.org>; Mon,  3 Dec 2018 17:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kmtRi8dm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB7C420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeLCR3b (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:29:31 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40590 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbeLCR3b (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Dec 2018 12:29:31 -0500
Received: by mail-pf1-f193.google.com with SMTP id i12so6703037pfo.7
        for <linux-integrity@vger.kernel.org>; Mon, 03 Dec 2018 09:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/2978KeymCCG4obj+t3KtabbIzyL17/R++V1p7tcHi8=;
        b=kmtRi8dmHMibPVkNRh3mdhYpt69wlCGGGEnJQnW4jP74FuKWcNYFwczCM0iveulcbm
         B+MY3yqmm/+5Qgm5ctvewI3Lh7xu/+SfGqavSEnsjqOt1shS/29DQbcLR/VbhfOdGbx3
         8RVhuzHtWRE1U5iPuqcxYR73m1oebT5xalBOfrbYXgqlN+lPpERSBmqtKsU4X8fAl5F2
         eCN0+3TMlwNMdwd4X+Ynx1nmB6YJHewbDj33Y+jyXWYvez2TUU5nr5MKFgz8yu35tUK2
         SXH4RpqK1O1GF4LYti/iTgilj8cfSmgth/SSTVSAhi+XdW+EsHMTWIL131nm3CeaG3KP
         FNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/2978KeymCCG4obj+t3KtabbIzyL17/R++V1p7tcHi8=;
        b=bHJgXAIbNkYMrDvnJMUHbG0P/qcwIEDgmBw7BnWOVXebM2621WZv1BSxOlCx9nSeRp
         RpPoh14AQEToe1nIli6NqX6bIsdYfgSHlv89rkRqSRE3kWEIy0ATecswAXEW/p22V2rr
         rzSWRLmUY1eyqNHhT1u/O8SCHZaw5PLAMvtR833D5PI5NA9C+CekABZgVL38XS7Ipc0/
         Xunh4a4eS6WtdPuvaySl1csm/5h0BfaTQdYj06/C/3NMgbiKR9H+PVOoBVSEDryE1H1f
         U+edP+fz3Q0NWampsn1gUcRJ30xlL8fxRXtaPmLQmjEG5MkELUJm2LSOdo2S0wvwoYKp
         8A/w==
X-Gm-Message-State: AA+aEWaw3XuPnj6bF8wT8ojLXwVo1ik2FLQKL+80uYkfoS9vSIND5/33
        SACHjgPqLpYsD/iTu2m5GEWNOg==
X-Google-Smtp-Source: AFSGD/XuCm/+CZe8ORdfg5yQ+0RCucKnov4Yad5oh9bZxhlF3xQWoBGo9WVeknzHvb+8FyfFlkzRlA==
X-Received: by 2002:a62:3141:: with SMTP id x62mr16572007pfx.12.1543858165110;
        Mon, 03 Dec 2018 09:29:25 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id m20sm15497239pgb.56.2018.12.03.09.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 09:29:23 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gTs26-0004Or-EM; Mon, 03 Dec 2018 10:29:22 -0700
Date:   Mon, 3 Dec 2018 10:29:22 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Huewe <PeterHuewe@gmx.de>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Re: Re: TPM legacy
Message-ID: <20181203172922.GA12237@ziepe.ca>
References: <20181130233501.GA32256@linux.intel.com>
 <1543764226.4216.205.camel@linux.ibm.com>
 <1543775366.2732.24.camel@HansenPartnership.com>
 <20181202231327.GC6718@linux.intel.com>
 <trinity-c862f498-65a2-43f4-a4b3-94cc4b8e1c66-1543849298447@3c-app-gmx-bs70>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-c862f498-65a2-43f4-a4b3-94cc4b8e1c66-1543849298447@3c-app-gmx-bs70>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 03, 2018 at 04:01:38PM +0100, Peter Huewe wrote:

> The only thing I would want to get rid of are the *1.1b based*
> drivers - they are probably end of life since quite some time.  The
> TIS driver&specification has been around since 2005 if not longer...

I also wanted to do this, I feel like these drivers probably don't
work any more after all the churn in the past few years..

Jason
