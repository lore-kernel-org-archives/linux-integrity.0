Return-Path: <SRS0=JWD1=RJ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2783C43381
	for <linux-integrity@archiver.kernel.org>; Wed,  6 Mar 2019 23:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA19D20675
	for <linux-integrity@archiver.kernel.org>; Wed,  6 Mar 2019 23:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SUs5HVUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbfCFXga (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:36:30 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35577 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFXg3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Mar 2019 18:36:29 -0500
Received: by mail-io1-f67.google.com with SMTP id x4so11837037ion.2
        for <linux-integrity@vger.kernel.org>; Wed, 06 Mar 2019 15:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=illxuNs+pJxmnSg30l98Ud1l0zVtjJ7VYu79tMza5Yk=;
        b=SUs5HVUyJ3Yg2asVZKC3geeSL1dCJbHHPsMCmk71AJ6lsWmFQCD8LCazH2HxuQli74
         MHgjHLJIPpCCpnXQz/gI4aje0s3BNmxEmyIQk29J3ej8eriEt8tdT0mdBUhfVRVV5Qd6
         1WbRMBty5VIK65c2CRzERqjcOyyAk7hSaNG7Ot+oL3t8VRIzxR/xQjOD6eR3v4qDL5uc
         KE/clTTz7ycatEblE7Jbmc49CE/pjGwzAIzMd9M/4BqPSyiV/UwgJFtshlRejpK6CBh2
         skym6vWMrjFckqtDJdrtzWKq1AvrxJB6yjqOCtniRG6XVheSy8VApJ+UDDyECjzTumJd
         A9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=illxuNs+pJxmnSg30l98Ud1l0zVtjJ7VYu79tMza5Yk=;
        b=ubi8KSbFejpQI/b6JGPqbD2HauUn5mTlR+pA7kq6sJNAo4HhKm5PtTTSwVAcCyDU4x
         KmMZOcV1wcTZjMP3Ye5C3qg0LPnqt28tg8RjlaugTgQn4aP9dOmSLR9ej9r3sN2BGpLL
         Ozz/BiT6dAj0eKqfKAxiP3vy24VVYoCHj16CGHok9AYCgcUwMGeuiVY4bcjB7UQ9zI3i
         EO+fMdULWWHn9WNU4UR2b4ephhhsuT8MDM+YtHnuYIOrHSCSUOxBf4F0OsnZeNY/mI8B
         5NpGGy4jVRZdAkdnMc+5e0jfFRtaD/Y5qMDD8zRSTiDkE3LeFyWeMRDFgu2QwHc3vzGr
         zBgQ==
X-Gm-Message-State: APjAAAU9wb1bKVIxVL5qCks0pmyVljAZhBPVpSt+KvTsssDAOFu6Rh2u
        nwqbFtkH5uZ6cvyFa+Mn5NyUXxWvGGxqGmJyd7OPXA==
X-Google-Smtp-Source: APXvYqwcRIb1dLTLcGOdsNYWuK5HRy5Nasfkwv3FyLykx+BYQ20Mb92jAIVNEM5vXK59tGAFKOh5FMq8C8ah/2iG38Y=
X-Received: by 2002:a6b:ec19:: with SMTP id c25mr4724432ioh.169.1551915388364;
 Wed, 06 Mar 2019 15:36:28 -0800 (PST)
MIME-Version: 1.0
References: <20190226215034.68772-1-matthewgarrett@google.com>
 <20190226215034.68772-4-matthewgarrett@google.com> <1551369834.10911.195.camel@linux.ibm.com>
 <1551377110.10911.202.camel@linux.ibm.com> <CACdnJutfCxzQDeFzXmZ9f8UrnqNScErkBJd2Yu+VEoy4nBhBCA@mail.gmail.com>
 <1551391154.10911.210.camel@linux.ibm.com> <CACdnJuuRLDj+6OTohfTVzqXp1K7U3efVXXuFfBfhk3CiUBEMiQ@mail.gmail.com>
 <CACdnJutPWEtDMS6YUXF0ykq7gKgQRNk6Fw=aHivHz6+NTodsgA@mail.gmail.com>
 <1551731553.10911.510.camel@linux.ibm.com> <CACdnJutWRB1up6wO3aWJJah3p8k+FY6xEfjw8ETHT69Vvsz8GQ@mail.gmail.com>
 <1551791930.31706.41.camel@linux.ibm.com> <CACdnJuvfzvZaU3CHtvVAP6vj_-rnWeTyAKjmRj8QGt7WAmjicQ@mail.gmail.com>
 <1551815469.31706.132.camel@linux.ibm.com> <CACdnJuvhu2iepghLm4-w2XVKH+TVT1JAY=vtKtf733UXPSBPaA@mail.gmail.com>
 <1551875418.31706.158.camel@linux.ibm.com> <CACdnJuvRuagNTidkq3d4g_OwfzqcALtd=g1-5LDzr2aBA1zV6w@mail.gmail.com>
 <1551911937.31706.217.camel@linux.ibm.com>
In-Reply-To: <1551911937.31706.217.camel@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 6 Mar 2019 15:36:16 -0800
Message-ID: <CACdnJut9T0xE-Q+ZAfqaRMUeBX=7w+cYE5Y7Ls1PdH-bJfv8MQ@mail.gmail.com>
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

On Wed, Mar 6, 2019 at 2:39 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Wed, 2019-03-06 at 10:31 -0800, Matthew Garrett wrote:
> > Ok. Would annotating the audit message to indicate that the hash was
> > provided directly by the filesystem be sufficient?
>
> The audit log doesn't have the same security properties as the TPM
> quote and IMA measurement list.  Nor does the attestation server
> necessarily have access to it.

Ok.

> > I'm not clear on
> > why an admin would set this flag without having read the documentation
> > for it - like many security features, enabling an inappropriate
> > combination of them may result in bad things happening.  I'm not keen
> > on tying it to signing because:
> >
> > a) There are multiple configurations where requiring signed policy
> > doesn't give a security benefit - if the IMA policy is part of a
> > verified or measured initramfs, we already have integrity guarantees
> > and adding an additional layer of signing doesn't win us anything (eg,
> > in this configuration the IMA key may be loaded from the initramfs as
> > well, so an attacker able to modify policy could add an additional
> > signing key).
>
> Agreed, as long as there is no possibility of additional files being
> installed/downloaded to the rootfs or files on other filesystems being
> accessed before the IMA keyring is locked or a custom policy is
> installed, a verified or measured initramfs might be enough.
>
> This implies that both the custom policy and the keys loaded onto the
> IMA keyring are included in the initramfs, which isn't what is
> currently being done today.  My preference would be to remove the
> original method of loading unsigned IMA policies, but that could/would
> break existing systems.

It's the way we handle IMA configuration - the policy is loaded and
further policy loads are disabled due to IMA_WRITE_POLICY being
default n. We're not currently making use of signing, but longer term
plan is for the keys to be loaded at the same time.

> > b) Users who are already using signed policy won't get the additional
> > hint that you think is necessary.
>
> But they would have to knowingly add "get_hash" to the IMA policy and
> have signed it.

But in the non-signed case they'd still need to knowingly add
"get_hash" to the IMA policy. Why does signing indicate stronger
understanding of policy? If my understanding of ima_match_policy()
correct, if there's already a measurement rule that applies to a
filesystem then adding an additional trust_vfs rule will be ignored,
so once the initial policy is loaded it's not possible for someone to
transition a filesystem from a full read to using the vfs call. IE, a
policy like:

measure
measure fsmagic=0x46555345 trust_vfs

is still going to perform the full measurement even on FUSE.

> > I'm happy to add this if there's a real threat model around it, but
> > requiring signing for something other than security reasons seems like
> > it's conflating unrelated issues.
>
> A colleague said, relying on the filesystem to provide the file hash
> extends the TCB to include filesystems.

The TCB already includes filesystems - IMA's measurements are only
accurate if the filesystem returns the same data on subsequent reads
(assuming i_version hasn't been updated). We assert that this is true,
but it the filesystem is outside the TCB then that assertion is
invalid.
