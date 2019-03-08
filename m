Return-Path: <SRS0=eg0d=RL=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67B3C43381
	for <linux-integrity@archiver.kernel.org>; Fri,  8 Mar 2019 20:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B2420857
	for <linux-integrity@archiver.kernel.org>; Fri,  8 Mar 2019 20:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qcu93xVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfCHUW7 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 8 Mar 2019 15:22:59 -0500
Received: from mail-io1-f48.google.com ([209.85.166.48]:45791 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfCHUW7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Mar 2019 15:22:59 -0500
Received: by mail-io1-f48.google.com with SMTP id x9so17765680iog.12
        for <linux-integrity@vger.kernel.org>; Fri, 08 Mar 2019 12:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7kPqabAbJ+GgmrQih894fm1IROGUPdO8kPS7MzSjgwQ=;
        b=qcu93xVtH4Qvq7lNP0Sul72S/hamhxAyYWyZiv4TjgYHxSFOQ7frztz2L7VzrcWzk3
         1q5aKqt23oRc/ALmksMJHMifcGUxltqXwLAzA2DK2zYE8YLfNCDEiH5mHi+c2wWjfSCu
         CaGVOdMAR6Ja0c8p7beJk40+4LcoFc06VDiuhVuoCPcoyxars4ZeP6A5okHN21d92HIM
         DrM4SaEKZ2dgx0lXECteYSBfW4RsWPQO50thMCvBEsYpv7HCYgohKnVpIO9VWh11iA0F
         SX7vgPD17UTq/b0tpgYsqcNzQc+r79korDztQshdaiuYB8nTs+s/8pIov1/YcAsbqWiW
         tR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7kPqabAbJ+GgmrQih894fm1IROGUPdO8kPS7MzSjgwQ=;
        b=ffB7u/jaVDWbe1+Av+HMWDCAWfO3o3kfqqAgL/L7QVDuJVSOuQcZ94U65vEDc5G+FV
         tnBhaHI3PPQnJro4wJD+tin92JUlw7dnRjig7JIEyYj89+yRM0eGZ47K/hMhsur3/WPe
         o+D8oi+U5TH3KF+llQO2J1QjT3ebF7zsmULiLYm/w+PK6mO0f8bZc8VS0eYXv+6Qk3m8
         PNmKVWdUonq0ditjBnFPcVFvrJJDdsgeRIX9EiH1edJutN6CO/G1nUWCfFVYeioPaVlJ
         b8i4OblyFbZ++t/guxV03+Qd32m0McHT2Pg7SprvJld2ng1ybkXg7vDvaPt2NjR0GcVv
         QQQw==
X-Gm-Message-State: APjAAAXKDpUfm1Z98H0VzJu82UALwDzVE71izewtSuRCzaSsdph6EKhI
        90nHnsvhT4sB9L/he6hT8FRJEzLq10zowRbSPwsAag==
X-Google-Smtp-Source: APXvYqz9pczc+sHkX/9jpRNPOJZYKUYZUkbSSsyvI+gwVT8Xy1U7lyMFcyR5Karr3xZ2WlRfZIe9csfD2ldxlJ90lyE=
X-Received: by 2002:a6b:ec19:: with SMTP id c25mr10621944ioh.169.1552076578180;
 Fri, 08 Mar 2019 12:22:58 -0800 (PST)
MIME-Version: 1.0
References: <1542657371-7019-1-git-send-email-zohar@linux.ibm.com>
 <1542657371-7019-4-git-send-email-zohar@linux.ibm.com> <CACdnJusqHZ1OLJD1baN=fXK9KE+bSqzB4OUbmLXH5-qZNrQXJg@mail.gmail.com>
 <CAFbkSA39RwB+E4SaG_ueu-_B=y7JytEYKw1+eXNQ_eCuMfnv=g@mail.gmail.com>
 <CACdnJuuHmK0qKjMxxonRYDUCatxqs930QGNQmREhRjimpNKzYw@mail.gmail.com>
 <1551998897.31706.461.camel@linux.ibm.com> <CACdnJusiLSCyqx7NX5bkpFr2N5YjBt_h3miOgkbey-Zndc3+Kg@mail.gmail.com>
 <1552052377.4134.23.camel@linux.ibm.com> <CACdnJut3Y7CogvgtNsEcrEtA1WOxSb9OWP_wZ=3xNgCft2oeDw@mail.gmail.com>
 <1552070598.4134.51.camel@linux.ibm.com>
In-Reply-To: <1552070598.4134.51.camel@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 8 Mar 2019 12:22:46 -0800
Message-ID: <CACdnJuso1o=fib+fUuY_f2ibJKD5N=kr_BrAtgu_srHCcRLKig@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/ima: retry detecting secure boot mode
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Justin Forbes <jforbes@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        kexec@lists.infradead.org, Nayna Jain <nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Mar 8, 2019 at 10:43 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> FYI, efi_printk() works before exit_boot(), but not afterwards.  The
> system hangs.

efi_printk() uses boot services to print, so that's not unexpected :)
It would probably be sensible to return an error rather than crash,
though=E2=80=A6
