Return-Path: <SRS0=AHf6=B4=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2272EC433E1
	for <linux-integrity@archiver.kernel.org>; Tue, 18 Aug 2020 17:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E030D20658
	for <linux-integrity@archiver.kernel.org>; Tue, 18 Aug 2020 17:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kWpHYPWk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgHRRRS (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgHRRRP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 13:17:15 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EAFC061389
        for <linux-integrity@vger.kernel.org>; Tue, 18 Aug 2020 10:17:14 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id y11so9914761qvl.4
        for <linux-integrity@vger.kernel.org>; Tue, 18 Aug 2020 10:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ttbT2mTFkL7U/k1BhEfBJx+7CNQrKmyQm2e1D/12PIA=;
        b=kWpHYPWkbXRbfLs70Cb/ol6V/EW1MUiACbqxoB3XB5pc2tMzRgo/+kHXrZL5wnasZ+
         peESubAcZHbnoZbGKHK9B5f4LitEDyAI0YTM5XT8EYKa4AorkVUIRFxzQCHw2R4YXxHH
         hlbqGpwYSk4AW0N0ZLUobKnpBxYvdVq2If4czm15fMjjgly8ZoVlvYLBGX/b1ByjfNO8
         Aw3s9ELNTEHt81R3w1GhwMb1gIwDVZHlIpWigOy9+GZqvuzvofJgZYp95amZt7pcooBx
         pLHhZJv2lnp/2P1xOlzzaC4LuYnRFqWGHWuXfnn4miO5TLXoBp56i13hA2/IGFeu390v
         aO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ttbT2mTFkL7U/k1BhEfBJx+7CNQrKmyQm2e1D/12PIA=;
        b=k24/e2MCkzTh7lAZ0mtaKCmC5JnKpEtAIa5AyN2vX5XIwL66vFL9Tpaz6Vzmme44wB
         pa8u/VkRIxYHrEbqBNuB2DCMSZrFElgMIvJpmN/Qk2kMxF8LVjZfm/6WNYEUmKKQN32I
         ZNK8Iu5T9BMuo92p0A0f5jcqyo33/uxymr4aLZsod8ZmAl8rATVHDY9+u8VMEJ5iJI6n
         gEDwgnRu7xxI3Z1+6PwuMck/ESUwmzlvidyrRNWZeE8ZsnTnDZtBuYPQv8OzUAMMMR+X
         qEISceu2AFVbyTirOJwXbZR9am0rFpQt9ksTsE0VxuQHxTYFbS6NLJSOju7e09wWV+mE
         67fQ==
X-Gm-Message-State: AOAM5316ITl7PfU0ncHuTlgRVHULOwuWO3ncMQr4yQeNv3QrktfB+s3q
        0FGz95meLjl8KY9+WMojJ0KHCie1IOPRUg==
X-Google-Smtp-Source: ABdhPJykKqhra7rLuOkY0+rDheKaJBHnpXo+WDY+OaC8q7MsldtJOAUg5fqbUHy9FnSnNR4pc4qy5Q==
X-Received: by 2002:a0c:fbd1:: with SMTP id n17mr20298217qvp.4.1597771033972;
        Tue, 18 Aug 2020 10:17:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id n15sm21225511qkk.28.2020.08.18.10.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 10:17:12 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1k85EW-008WE9-Cs; Tue, 18 Aug 2020 14:17:12 -0300
Date:   Tue, 18 Aug 2020 14:17:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20200818171712.GZ24045@ziepe.ca>
References: <20200817213506.4474-1-James.Bottomley@HansenPartnership.com>
 <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
 <20200818161207.GC137138@linux.intel.com>
 <20200818161955.GD137138@linux.intel.com>
 <1597769070.3898.36.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597769070.3898.36.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 18, 2020 at 09:44:30AM -0700, James Bottomley wrote:

> The question you should be asking isn't whether the information *could*
> be obtained by other means, but whether providing it in this form
> facilitates current operations and whether the interface would have
> users.

Sure. What are the use cases that need PCRs but no other TPM
operations?

The cover letter didn't say. As PCR is really only useful in the
context of the local TPM I'm not thinking of anything..

Jason
