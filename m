Return-Path: <SRS0=MdHQ=RR=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4A5C43381
	for <linux-integrity@archiver.kernel.org>; Thu, 14 Mar 2019 21:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CC12087C
	for <linux-integrity@archiver.kernel.org>; Thu, 14 Mar 2019 21:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YCS7Z/hB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfCNVIY (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 14 Mar 2019 17:08:24 -0400
Received: from mail-it1-f182.google.com ([209.85.166.182]:54787 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbfCNVIY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Mar 2019 17:08:24 -0400
Received: by mail-it1-f182.google.com with SMTP id w18so7029911itj.4
        for <linux-integrity@vger.kernel.org>; Thu, 14 Mar 2019 14:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D6sUsmfg4XROCNJoZPyvAcFYbY4KpjSGLl2/ySGMOD4=;
        b=YCS7Z/hBS/yIUrQlDC7SxqHokIOZhl3dsk2LXn5D1ZkygRvqnlo9Feipn6oDhnu7Gr
         w6Ywcoon1MPsKRfbGyTD0GOVqqbI9j3hc4a2IREMavWn94RgAj/PD1uMU4qRhxchnAUg
         Qv2l/SqV7z26IGBp1BcQGvB6YZYv8yWr9iC2BZJlZf72J//4+k0JzmfvoOEGZLZZol8X
         k+nuRrHurtBeKDEFowpysGGLGXo8j/jZAd2bV9fGfGWCPTWykDJBEC9V/aRb6iLpit2W
         ANFAj2C6ibBcXu6n9RSBMbHRdTbBV+/jtapxnEI+Uh++KMLNzBdvZ69xS/2Q5ujZUZDj
         I2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D6sUsmfg4XROCNJoZPyvAcFYbY4KpjSGLl2/ySGMOD4=;
        b=RwQ2G4WGjsMrJEuWw+Oxn95Vot0c41UYbiNgK/bMpkStbdSsT2ih46cSVWuzt1HqlN
         kqu84kzxB7yWXWylTk4ij8HAcfmcl8rzajw3EHtRFNH8KlYYVgV5l2wh/79YN/O8jlYS
         /gbMDhM9tyA5Cwppncg7Hql7lRzKZB7HHfjij8dpSTNdFjbShWTAqKcSmX9WYIRkdQRF
         OHYBZp245RMjhC82Ju8VVqHBOH6IqbXZQ/TINGjXZeiks7T9tH9oURMdJD2vKUAdlEYH
         bW/fJuhZdL5q0OrXZodhL2j+t5nQAUdbLYIpYhOG7qOIgcREZm2ata6RVFVRRgr7ZOMg
         VfsQ==
X-Gm-Message-State: APjAAAUMTq2e/EVAelf8kOZokeNT3dxrz4VjKofSNZlYvdb/h/lwfloH
        tx3Uvz0gSCN2gg/3DvsGykvoAIpxYQmEO1DnbJ7ahg==
X-Google-Smtp-Source: APXvYqwDBRMmLnj6OAnSV4MhWKHsEiolwz/9AuvBZU7bPDnsulQM/tVtQHYuHqYI9Cj2IWeaDxyCwtpR1Fhq6/7U3H0=
X-Received: by 2002:a24:2c48:: with SMTP id i69mr357340iti.161.1552597702353;
 Thu, 14 Mar 2019 14:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190312195715.101995-1-matthewgarrett@google.com>
 <1552478316.24794.210.camel@linux.ibm.com> <CACdnJuvThFMhGtKT9PYSH-jZD69CBktQNiJmCc=d4PFRbzQvGw@mail.gmail.com>
 <1552512556.24794.229.camel@linux.ibm.com> <CACdnJutmJDLhrdsU9UZtzE+S=Tw39RYqZ3q+TP35PbFbfsL76w@mail.gmail.com>
 <1552525698.24794.237.camel@linux.ibm.com>
In-Reply-To: <1552525698.24794.237.camel@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 14 Mar 2019 14:08:11 -0700
Message-ID: <CACdnJuv=-Gr9Psd1ABZ=fW43-2FHcgEkG_iu0bY20Jx4Vro=mA@mail.gmail.com>
Subject: Re: [RFC] kexec: Allow kexec_file() with appropriate IMA policy when
 locked down
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 13, 2019 at 6:08 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> The IMA hash and EVM hmac combination is fine for offline protection.
> It's used for mutable files.  For immutable files, there must be
> either an IMA or EVM signature.

Ok. Is the correct way to handle this to check that the file has a
signature, or to extend IMA policy to allow it to provide a
requirement that EVM verify a signature rather than an HMAC and have
the arch policy set that?
