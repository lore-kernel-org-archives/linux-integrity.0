Return-Path: <SRS0=PR+Z=RI=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27074C43381
	for <linux-integrity@archiver.kernel.org>; Tue,  5 Mar 2019 18:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D8D2087C
	for <linux-integrity@archiver.kernel.org>; Tue,  5 Mar 2019 18:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U86kEYPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfCESjl (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:39:41 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:36546 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfCESjl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Mar 2019 13:39:41 -0500
Received: by mail-io1-f66.google.com with SMTP id r136so7904907iod.3
        for <linux-integrity@vger.kernel.org>; Tue, 05 Mar 2019 10:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NqhaArBz66+USrocqsB/kEDuJO0ZX+hpqzth7MMFRmw=;
        b=U86kEYPJtrL1wbWWHspxfJZwuHv7RqHyDsPnnIQ2m4Y9zDIfNXx+S9pCGj1EIb+R31
         6ZSohIR4VA3z8aN0RTGGXhoZQAqb3C3FZpVtsiS4YMoG/m8JfuK+oVmxupUDwDGFtnFT
         F3Q9AGJ5s93EJmnevojTzmco32Vm4ef36qgr+6ppCSkk9Dt2ErgARMWDKjB3e7+bwtwA
         9MDmx1skD/I2vEJ8/BdHVgELU8UsdgHN8KRqbdOL2EsG0FZL9EfKuU82AYJOUfo6Yu7q
         1xAInOUT+J5EpWQP+5B/inToE8wglKDNKiNoLUdgtRTXgq3/qK0BAi6nwKotUziMYOD7
         BKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NqhaArBz66+USrocqsB/kEDuJO0ZX+hpqzth7MMFRmw=;
        b=a0eCVqhU9Vtes1F8qHuY5i4vxGzUTDbtbrXQrpa/dIGrt3VNhF3lEawvNJfGtVJ0rh
         WgLnUCsSTvHf5g6oZBRRuaEZt5Bz2V3hMBg5vez4B20JT2bv2WyIOjYF4ls8W0DYPXqO
         hfrydA7KX4/b2+CGZRId+4LQmMC/5up/NAjKUPvdIzXTitzlux8sEvNP/OPHprsMjY3s
         e4uSE3M1brgmP+Ijq3VJpbF7h7aj7rzJ/Y/FffGAe1GQcWW3D2MWK2hx9iMWD4qm+xzg
         /pI0Q5817FR3ooD4k5YrHUBoKLZbwClXRvfLrTvo7C+5HomJbyDCJPO07odcQ5jDki8o
         vOWA==
X-Gm-Message-State: APjAAAVZwmFFi9UmMLy6Hvt8OOcTldO7PePPEhniyAToW2OQzec3idxY
        XDQUQPQvsH0JEo2vJ0InNeUwy0ByDO9tNhicUqnEXw==
X-Google-Smtp-Source: APXvYqyHvAbo0yo+pjYZuYB7qZLDyesXVUCHU2k5FmVYioNDYrEujjGW8DIxh6rsoi1AKbPKii1OKblED/3kHmz2ssg=
X-Received: by 2002:a5d:9254:: with SMTP id e20mr917176iol.88.1551811180186;
 Tue, 05 Mar 2019 10:39:40 -0800 (PST)
MIME-Version: 1.0
References: <20190226215034.68772-1-matthewgarrett@google.com>
 <20190226215034.68772-4-matthewgarrett@google.com> <1551369834.10911.195.camel@linux.ibm.com>
 <1551377110.10911.202.camel@linux.ibm.com> <CACdnJutfCxzQDeFzXmZ9f8UrnqNScErkBJd2Yu+VEoy4nBhBCA@mail.gmail.com>
 <1551391154.10911.210.camel@linux.ibm.com> <CACdnJuuRLDj+6OTohfTVzqXp1K7U3efVXXuFfBfhk3CiUBEMiQ@mail.gmail.com>
 <CACdnJutPWEtDMS6YUXF0ykq7gKgQRNk6Fw=aHivHz6+NTodsgA@mail.gmail.com>
 <1551731553.10911.510.camel@linux.ibm.com> <CACdnJutWRB1up6wO3aWJJah3p8k+FY6xEfjw8ETHT69Vvsz8GQ@mail.gmail.com>
 <1551791930.31706.41.camel@linux.ibm.com>
In-Reply-To: <1551791930.31706.41.camel@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 5 Mar 2019 10:39:29 -0800
Message-ID: <CACdnJuvfzvZaU3CHtvVAP6vj_-rnWeTyAKjmRj8QGt7WAmjicQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] IMA: Optionally make use of filesystem-provided hashes
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 5, 2019 at 5:19 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Mon, 2019-03-04 at 14:10 -0800, Matthew Garrett wrote:
> > I'm not clear on why requiring signed policies is helpful here. If you
> > allow FUSE mounts at all then you need to trust the FUSE filesystem to
> > return good results, in which case you can trust it to return valid
> > hashes. If you don't trust the FUSE filesystem then generating the
> > hash via read doesn't win you anything - the filesystem can return one
> > set of data on the initial IMA hashing, and then return a second set
> > later. Requiring signed policy doesn't change that.
>
> You're defining a new generic file ops "get_hash", but are using FUSE,
> a specific filesystem, as an example.  Requiring the IMA policy to be
> signed when using "get_hash", is proof of the sysadmin's agreement to
> bypass actually reading and calculating the file hash.

We can trust in-kernel filesystems to return reliable information.
Network filesystems have the same issue as FUSE - we're trusting that
the remote endpoint won't give us different information on successive
reads. What's the threat that's blocked by requiring signed policy
here?
