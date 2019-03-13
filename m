Return-Path: <SRS0=IrrW=RQ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F671C43381
	for <linux-integrity@archiver.kernel.org>; Wed, 13 Mar 2019 21:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DF62087C
	for <linux-integrity@archiver.kernel.org>; Wed, 13 Mar 2019 21:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k7eq7BAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfCMV7f (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:59:35 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39262 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfCMV7f (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Mar 2019 17:59:35 -0400
Received: by mail-it1-f193.google.com with SMTP id l15so1373250iti.4
        for <linux-integrity@vger.kernel.org>; Wed, 13 Mar 2019 14:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fc7p2YCrUlPzgoHhkfdKCKotR6ODs1ZKHRHAH94ObFg=;
        b=k7eq7BAmFDL0ri7lv8AKAVLmy7k+7zhOrKTMX9eBph36Br8HNgrHDn2yOmMHAfJG2T
         exYKThGDWcrYKatYgKxedlUr9Vuj1/PceTHbiWezAJOGiyrOK7/Dij5zsXju8+pYsOQ5
         b8wafYpKPT6LODGltZu9lkljAnU67pS+eHz6HaGhzMx40vQKq5Ic6OVFGX2Cilyjnt/y
         goZrooOL8b+jrSx0voOlweqet2SRyffBoSoBMoKiDB5wAjne7fHPun81l2Sqn+j2Xf/h
         1m3DfQFy76UoZ1GhoWuAGtX8PjBfiwC6JmQ8TX9QFTEdcKwFhOg5FnCbrRCzNtXeNf6U
         0ibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fc7p2YCrUlPzgoHhkfdKCKotR6ODs1ZKHRHAH94ObFg=;
        b=VDAG0xPwpnfpKI2yS6kBqaYSRhtDiBmCF4ltZm77H/Vg8FGaWuV6tExex/vQSDCyuF
         WDkj6Ny1gqBrop8QW0uDBOynu4jfQSPWfBZskZeAkSJo4AP2Ztp0z4EBKLMBsobZvByi
         yG5aU8SODbCDj/dkY0cjhId0l26EGTzPGzZJz4O3M+1HTNNnT/FD+Y8KpD3e0IRQO5pd
         2A1uOzGEtsguR2qC24+6k6i8YbXii83KR/qOqgykGJ3qbyf1oPpmKk/LOmEDlM3o3Hsi
         1B+2UFOPKXc+nj0p1sZS0NOdWAOguwYVOIvIUAfys69u+LNqSufgzks4lHJSpmFnGOvA
         r3Lg==
X-Gm-Message-State: APjAAAXdrkdpr0q1FND9G3Yu+xrNKpnTNrDCFJY/PvQvYShQ29TM0LXR
        vk4oGMsPhk5fMtbd563Pbc86qtDJI7k93uKWw+WUsg==
X-Google-Smtp-Source: APXvYqwS08XZeAeBd3Q2umF63Eig/UNQTU/QGNpTxqnd5hBvVpnagd7GMWfIJonKqqN4AXkog1xQGRQuHYEHigcSUF8=
X-Received: by 2002:a02:23cd:: with SMTP id u196mr6017825jau.103.1552514373778;
 Wed, 13 Mar 2019 14:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190312195715.101995-1-matthewgarrett@google.com>
 <1552478316.24794.210.camel@linux.ibm.com> <CACdnJuvThFMhGtKT9PYSH-jZD69CBktQNiJmCc=d4PFRbzQvGw@mail.gmail.com>
 <1552512556.24794.229.camel@linux.ibm.com>
In-Reply-To: <1552512556.24794.229.camel@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 13 Mar 2019 14:59:22 -0700
Message-ID: <CACdnJutmJDLhrdsU9UZtzE+S=Tw39RYqZ3q+TP35PbFbfsL76w@mail.gmail.com>
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

On Wed, Mar 13, 2019 at 2:29 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Wed, 2019-03-13 at 13:36 -0700, Matthew Garrett wrote:
> > Oh hm. The only case I can see where this isn't sufficient is if the
> > filesystem returns EOPNOTSUPP for the EVM xattr, but in that case we
> > should already have failed to get the IMA xattr and will fail
> > appraisal as a result?
>
> The evm_initialized flag is an indication that EVM has been
> initialized on the system.  Both hmac and signatures could be
> supported.  Even checking for EVM_INIT_X509 doesn't provide any
> guarantees that the particular file has an EVM signature.
>
> (The hmac can be updated (eg. change in security xattrs,
> remove/additional of protected xattr), so we can't rely on them.)

So having IMA appraisal of the hash and hmac-based EVM validation of
the xattr security isn't sufficient? Is this just because of the
offline attack case?

> > > > +#if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
> > >
> > > With these defines, the function isn't limited to just "lockdown".
> > >  Either fix the defines or the patch description.
> >
> > The function will be called even when lockdown isn't enabled, but it
> > won't have any impact on the logic flow.
>
> Ok, so inverting the test order should prevent unnecessarily calling
> ima_apprase_kexec_signature().

Unfortunately kernel_is_locked_down(reason) will print a message
telling us that something was blocked, even if
ima_appraise_signature() then permits it, so we need to do it in this
order to shortcut that.
