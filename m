Return-Path: <SRS0=c8Vu=P5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413E4C282F6
	for <linux-integrity@archiver.kernel.org>; Mon, 21 Jan 2019 08:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D84C2084A
	for <linux-integrity@archiver.kernel.org>; Mon, 21 Jan 2019 08:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="l3Ayvj0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfAUIZX (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:25:23 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:36676 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbfAUIZX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Jan 2019 03:25:23 -0500
Received: by mail-pl1-f182.google.com with SMTP id g9so9470973plo.3
        for <linux-integrity@vger.kernel.org>; Mon, 21 Jan 2019 00:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qAJuTwmhZVJ+l20qDe/E1ZhaqKb+AHwi79FjZFvqF30=;
        b=l3Ayvj0J2QJ5hW6ccKcHvG6wUZneil9wxaGFt2SiGpVHUv0RnbaoinrNd9U/y+Dy5w
         y627LHPUoCgjYPEyl+f44SpeK8/XTsgU8/KY/u432hHxzyqi7AHyPcsM5kPJ7J8D8Fnc
         i8inggNhm8QbUMttVHhsUIHtGSLH0Kqms9fo+iG3yfxIUCIpRQQX6TlWwX2GlwZzPHjC
         vYi2E8bnwsUkaj9zrixWzjF4eKc8azuFid6/jW5XiQdDINM+8jpsxmm/iiMTUzbEZl2G
         UDZYiQ3H9MZcu0j6ofB0UeSoJGNYvpbYdgst00/5j9DYQN/8Q/s1YjfnKORdxTdUPQZD
         Fd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qAJuTwmhZVJ+l20qDe/E1ZhaqKb+AHwi79FjZFvqF30=;
        b=TQQr5kDsbPC6P7qJXM4HuT842AUnXHDK0EbZRVTjfWIs0T9Upwd8mLr2UyAduOdi/m
         XxPFDfrhHvem7Kgfli7UjUtJpxXMv/V+dUotJ479bGLz3t+pgqBZBGbiTGQuizwnlmyV
         OGlE5vpybxVIpkjIVKdBFTtIhFrRmCwU+a2i4pAT2cEt54XC1wyqy3ns4AVS5+L8UrTp
         QllyhB2N35Y+m0Y2tPAR/1U+VfC4FGsf/ps4g68thy2GvYIwaMqKwQ6eqBPbKlSGS3cK
         l8XEuA6aMQN0RwEOvHtTa2zViciXBBuugfX3FSa/ZHKBdkGg5IP3pNw7IVJI5yyTuwCh
         Zorg==
X-Gm-Message-State: AJcUukcHp/Tny1I2Dd67UCYJoJiqWzBu85sD7M3N1aFXRfnhJeiMWy06
        MdFR6VJw1pWZky8htEHUEcQl5OmrRDY=
X-Google-Smtp-Source: ALg8bN6kV/dC2xI5LXCmwvHq82uwjPyJeMn+wUxneWhMW10BGZQaUn8cNYL9zcrZ+aSwBmZA9qmdYg==
X-Received: by 2002:a17:902:968d:: with SMTP id n13mr28760058plp.109.1548037602103;
        Sun, 20 Jan 2019 18:26:42 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id v89sm14964723pfk.12.2019.01.20.18.26.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Jan 2019 18:26:41 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1glPIO-0005xp-64; Sun, 20 Jan 2019 19:26:40 -0700
Date:   Sun, 20 Jan 2019 19:26:40 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan.Morav@nuvoton.com
Cc:     nayna@linux.vnet.ibm.com, oshri.alkoby@nuvoton.com,
        dana.cohen@nuvoton.com, linux-integrity@vger.kernel.org,
        gcwilson@us.ibm.com
Subject: Re: device tree "compatible" string value for Nuvoton TPM 75xxx
Message-ID: <20190121022640.GD18017@ziepe.ca>
References: <63ed4dcb-a8ae-09ad-6793-8b1bb671d652@linux.vnet.ibm.com>
 <42e1f00b059f464e9d906cece191ed0a@NTILML02.nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42e1f00b059f464e9d906cece191ed0a@NTILML02.nuvoton.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Jan 20, 2019 at 03:53:46PM +0000, Dan.Morav@nuvoton.com wrote:
> Hi,
> 
> I've added Oshri who has been working on the driver, and Dana who is the TPM applications for follow up.
> I'd suggest "npct75x" to continue with the same line.

There are rules for the compatible strings.. Generaly they shouldn't
include x's if I recall.

If future chips are compatible with a first release then it should be
something like

'nuvoton,npct751','nuvoton,npct750'

Be sure to check with the device tree people

Jason
