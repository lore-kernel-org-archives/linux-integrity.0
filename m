Return-Path: <SRS0=c8Vu=P5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7B9C2F421
	for <linux-integrity@archiver.kernel.org>; Mon, 21 Jan 2019 16:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19F520663
	for <linux-integrity@archiver.kernel.org>; Mon, 21 Jan 2019 16:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LReDu7qg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbfAUQ6u (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:58:50 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37253 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729861AbfAUQ6u (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Jan 2019 11:58:50 -0500
Received: by mail-pf1-f196.google.com with SMTP id y126so10395001pfb.4
        for <linux-integrity@vger.kernel.org>; Mon, 21 Jan 2019 08:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HynGW9U086LfejyKSLzXXy/Bn6EDg3c1KcNKENWAbaM=;
        b=LReDu7qgVFKAgCGut4o28JciNfmJgf0ZH8q9CV+mJc1FqNR3IOAMkS/HQVqaoasKrs
         0J+QSqVx2FtPR2V58ZwcTZrfzF+Z1d0Ov/90Nv7SUgFZAFYhH6SiYo9J4KTxRoojHX/X
         VSqda5Nc8jonKG2lyEFAvDX5vB91UAZtVDdPtS5YpohBkqn7rCUiV+QqxpZLLHlo3ymo
         vnS5D5jBZphAmmRUpMufv8o+2eV4YMCGD5dKyk+Fs5Rqhy7z9fxzfA7ZNtiawimz2gsz
         BUqDLyQAl52oLJh7uqkRQDZv1fJOzFU3S8GD5HPDOetvaxmYOa4xQ5ALY+zbfdec/Oef
         BgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HynGW9U086LfejyKSLzXXy/Bn6EDg3c1KcNKENWAbaM=;
        b=la440T0ul5dwQeRCy/B5MSRqpN4c2Hg0F3IOnwjU1w7+78dSlxu191SA3am4C9mHJR
         SQFjW5/A461fKQhQRwl/yIaepowy16b3F4mnVetf+b4+tdb0DnyKr87K2imnpDBSVv+A
         6guGkW1LNLgRsNyoARw8eWPD5lXHYBzmqYliqz3DXdbXmdiGtGGW/QU/63KgCnXJvbnf
         OLYvhgpXB23iykJIk685oZvWmIee7aMFhkS7bE9TWa7AWKKvJlDCHxFYpTJMWVrWPTtQ
         KeAVwBvfk5lrsvi5Lxgr5Cy/YAtxUlCvvWEvs3ouANuIKx4rGN+Mz0iERBpJY0ofVzRa
         RLnQ==
X-Gm-Message-State: AJcUukfMj4HVEJ7Zu96MjWOMe5xNH4T7Ods5TOr0GccsB/GeD7Do13LO
        Bullr3HksiSdF5z101w0iWmpBQ==
X-Google-Smtp-Source: ALg8bN4VgcniUpXZLMqnygv80fkNggU2yQWCMUGkm6K6OEtkrwmKfAnaQZhd/62vujxsrpcMv0OqsQ==
X-Received: by 2002:a65:5c4b:: with SMTP id v11mr28678512pgr.333.1548089929723;
        Mon, 21 Jan 2019 08:58:49 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id r80sm22212681pfa.111.2019.01.21.08.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 08:58:49 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1glcuO-0007ax-6s; Mon, 21 Jan 2019 09:58:48 -0700
Date:   Mon, 21 Jan 2019 09:58:48 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     oshri.alkoby@nuvoton.com
Cc:     Dan.Morav@nuvoton.com, nayna@linux.vnet.ibm.com,
        dana.cohen@nuvoton.com, linux-integrity@vger.kernel.org,
        gcwilson@us.ibm.com
Subject: Re: device tree "compatible" string value for Nuvoton TPM 75xxx
Message-ID: <20190121165848.GC25163@ziepe.ca>
References: <63ed4dcb-a8ae-09ad-6793-8b1bb671d652@linux.vnet.ibm.com>
 <42e1f00b059f464e9d906cece191ed0a@NTILML02.nuvoton.com>
 <20190121022640.GD18017@ziepe.ca>
 <3e423306bfd14125a18f81f6b7bac136@NTILML02.nuvoton.com>
 <60e23fd0f0ff4d1f8954034237ae8865@NTILML02.nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60e23fd0f0ff4d1f8954034237ae8865@NTILML02.nuvoton.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jan 21, 2019 at 04:55:23PM +0000, oshri.alkoby@nuvoton.com wrote:
> Hi Jason,
> 
> Since the driver implements the I2C interface defined by the TCG
> PTP, wouldn't it be better to set the string to be something like
> 'tcg,tpm-i2c-ptp' (as 'tcg,tpm-tis-mmio' for tpm-tis)?  Any TPM that
> implements this protocol can use this driver.

Yes, probably, we've done that for LPC ..

But the device compatabile string should still be something like:

 'nuvoton,npct751','tcg,tpm-i2c-ptp'

In that case

Jason
