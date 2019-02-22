Return-Path: <SRS0=3PWC=Q5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31B1C43381
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 23:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CC2206C0
	for <linux-integrity@archiver.kernel.org>; Fri, 22 Feb 2019 23:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbfBVXFF (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:05:05 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32810 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBVXFF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Feb 2019 18:05:05 -0500
Received: by mail-qt1-f196.google.com with SMTP id z39so4491273qtz.0
        for <linux-integrity@vger.kernel.org>; Fri, 22 Feb 2019 15:05:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2Q+fUkM7Xd6GGZFe86QvR3iViAGPmrmZY6f7TTFC0vk=;
        b=HWxcFGCeYkUANFkQh7DgpEQPbjJ/M4MF8Wpu/ObK6hIyDujROBODcaPp2mFNJ/JTNQ
         hsCYwraJIStKKlTN8Grtrgo4FEMhM28xO+JqczS5OmRJ/gnV0wNBvOO6al7Y/C3etAy6
         lP7mdRHPOqprAvoT3c3lor7KAyYFBmfpfZtCOlUkBtHpdrzUalxO6TJDB7PzWSZ21uz6
         32RHt/+7i1V7opbobYtHVIp1KcFdlId/K64CES8IPTnrKSWAjADUFH0E4E5+L9Mwz1/M
         qMCWfbZY/hGGk/FMAGyOC2VhJrPzl+tFiMApNfc4rFQwQzVj+yYSOrhRyvyaq6RUX7t3
         nSqA==
X-Gm-Message-State: AHQUAubZMsAMdX/w/iRk0Wr2XchryNE4telFAlkFWCAUJYr0/CcTyuJx
        NW3xxuD4/d8q7thXYIWdG4jqAkIjMUS/jQ==
X-Google-Smtp-Source: AHgI3IZxx4ZgEECa33fr6MM5abRXlKdXNKf3bYFXJTB5ndGuQkqLb5lLfy4GWnGHd084Tip4B7Pocw==
X-Received: by 2002:ac8:1929:: with SMTP id t38mr5035014qtj.249.1550876704301;
        Fri, 22 Feb 2019 15:05:04 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id a206sm1685468qkc.55.2019.02.22.15.05.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 15:05:03 -0800 (PST)
Date:   Fri, 22 Feb 2019 18:05:01 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     David Tolnay <dtolnay@gmail.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, dgreid@chromium.org,
        apronin@chromium.org
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
Message-ID: <20190222180341-mutt-send-email-mst@kernel.org>
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
 <20190222102610.GB5613@linux.intel.com>
 <20190222101728-mutt-send-email-mst@kernel.org>
 <20190222193156.GA6475@linux.intel.com>
 <20190222193305.GB6475@linux.intel.com>
 <20190222161636-mutt-send-email-mst@kernel.org>
 <20190222215001.GA21427@linux.intel.com>
 <f16bd565-0a7e-d7bb-a5e8-eda48ac8de80@gmail.com>
 <20190222223634.GA27601@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222223634.GA27601@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Feb 23, 2019 at 12:36:34AM +0200, Jarkko Sakkinen wrote:
> I do not require spec quality documentation. Just a few paragraphs of
> what is in crosvm, kernel etc. and something about inner workings to
> get a rough idea. No need for TCG level spec for this :-)

OTOH for virtio if there's no implementation in a popular
hypervisor/language, we do ask for a somewhat detailed
spec.

-- 
MST
