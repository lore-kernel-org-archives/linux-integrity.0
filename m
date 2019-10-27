Return-Path: <SRS0=b11c=YU=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C22CA9EAF
	for <linux-integrity@archiver.kernel.org>; Sun, 27 Oct 2019 23:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7482067B
	for <linux-integrity@archiver.kernel.org>; Sun, 27 Oct 2019 23:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OV2CgShd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfJ0XAu (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 27 Oct 2019 19:00:50 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33974 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbfJ0XAu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Oct 2019 19:00:50 -0400
Received: by mail-qt1-f196.google.com with SMTP id e14so12025195qto.1
        for <linux-integrity@vger.kernel.org>; Sun, 27 Oct 2019 16:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9ucr+jOcw3G+VDCL6bizb9oLtSAC2iKYHZ/39iZyP6o=;
        b=OV2CgShdRhqoNNuh4gbrtksfZElzZUHAb57UbiuZhnU1xLoiveAmCzm1DzSSYASDHn
         9lJpIQbgUKKaiyYxu40d1CpFhWp84+z4TwVstxtXgsD4wz/jQE5n1rX/OzIw7eNZzFHh
         eZxNguN4xn6tOleZqlQBPnoEFoFZwhCDmM3vJ4LWqvbCCibzLP5wToSVU4qz3uq2mww/
         uBkKdiRGtfmV4CASLDB8vXJTpsThgGvM1zF9RxrObiAuZujbn5xPF7S38gE4NftznuMm
         kqB2ijpfcE/H1cWfy37qxyz52rS1XxSce03fxlyCv0lr+0DDyvZoH5d4u0vCIPyN1Lag
         0PZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9ucr+jOcw3G+VDCL6bizb9oLtSAC2iKYHZ/39iZyP6o=;
        b=UklFF7lBZwe4K9lULRYtHLWObYIgQ6JG1hC88iFCvUyQEFOdhtTU9t6SVi5Dp5/pwQ
         w+ZbLTpqjPs2hC9S8oL4KlEjbftleJ1QxCTyNFY5AHJkABZPHvmOsGhJL2IvtZHJmqoV
         7jPFLeCORjsOLxnXrBpVAGp6sF+v0L3Qm0NaV3abaEyDA3HpsnkWdBRgImKt4F45pbUY
         lhvqRBgvhnzmVsu88q/Er+AOWu5MdV9bcAN1wkLieBOYkOWo2z3Iwx8sRCiK8ND9v83t
         zkw06BRuUVYdVeMWgGr3mjz6IMKIuEBs2ZhQhZJ3n4y06mJ+/thr0e6dfRyrgnKp3nyd
         TPbw==
X-Gm-Message-State: APjAAAU7Sv2A+wGhJKlTQjAD7h66eQPXV7x0Bc4DwNHgL7+OS/Wjuu5h
        EOvhKUd1DcVBwd/AuTKlMWBaaA==
X-Google-Smtp-Source: APXvYqyWWhFTjCpEDYO5sVHAoYLVIqrn3UnoarAWxToW7OUg/nbZFBuA+Hp6+fNIahsOmiHNpEuZoA==
X-Received: by 2002:a0c:8d03:: with SMTP id r3mr2798634qvb.12.1572217247559;
        Sun, 27 Oct 2019 16:00:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id s21sm6675858qtc.12.2019.10.27.16.00.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Oct 2019 16:00:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iOrWg-0006CW-4I; Sun, 27 Oct 2019 20:00:46 -0300
Date:   Sun, 27 Oct 2019 20:00:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: Add major_version sysfs file
Message-ID: <20191027230046.GJ23952@ziepe.ca>
References: <20191025142847.14931-1-jsnitsel@redhat.com>
 <20191027153541.GA5222@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191027153541.GA5222@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Oct 27, 2019 at 05:35:41PM +0200, Jarkko Sakkinen wrote:
> On Fri, Oct 25, 2019 at 07:28:47AM -0700, Jerry Snitselaar wrote:
> > Easily determining what TCG version a tpm device implements
> > has been a pain point for userspace for a long time, so
> > add a sysfs file to report the tcg version of a tpm device.
> > 
> > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Cc: Peter Huewe <peterhuewe@gmx.de>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: linux-integrity@vger.kernel.org
> > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> 
> Please use version_major (e.g. if there is ever version_minor
> they order nicely alphabetically).

That is not the convention in sysfs

Jason
